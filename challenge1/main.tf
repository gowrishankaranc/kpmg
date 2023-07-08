terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.79.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

# Provider configuration for Azure
provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  
}

# Virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "kpmg-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnets
# Subnets for app tier
resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.6.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_subnet_service_endpoint_storage_policy" "service_enpoints" {
  name                = "serviceendpoint-policy"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "kpmgstgaccount24"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.app_subnet.id]
  }
}

// nic for web
resource "azurerm_network_interface" "web_nic" {
  name                = "web-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "app_nic" {
  name                = "app-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


#public ip

resource "azurerm_public_ip" "app_lb_public_ip" {
  name                = "applbpublicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"

}
resource "azurerm_public_ip" "web_lb_public_ip" {
  name                = "weblbpublicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"

}

// Presentation Layer

# Load balancers
resource "azurerm_lb" "web_lb" {
  name                = "web-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-web"
    public_ip_address_id = azurerm_public_ip.web_lb_public_ip.id
  }
}

resource "azurerm_lb" "app_lb" {
  name                = "app-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-app"
    public_ip_address_id = azurerm_public_ip.app_lb_public_ip.id
  }
}

# Virtual machines
#Presentation Layer
resource "azurerm_virtual_machine" "web_instances" {
  name                  = "web-vm"
  count                 = 2
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.web_nic.id]
  vm_size               = "Standard_B1s"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
   storage_os_disk {
    name              = "webosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "kpmg-web"
    admin_username = "webadmin"
    admin_password = "kpmg32!demo"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
#Application Layer
# Create Azure Virtual Machines for app tier

resource "azurerm_virtual_machine" "app_instances" {
  name                  = "app-vm"
  count                 = 2
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.app_nic.id]
  vm_size               = "Standard_B1s"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
   storage_os_disk {
    name              = "apposdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "kpmg-app"
    admin_username = "appadmin"
    admin_password = "kpmg32!demo"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

#Data Layer

# Create Azure SQL Database for the data layer
resource "azurerm_mssql_server" "database_server" {
  name                         = "database-server-kpmg"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "kpmg32!demo"
}



resource "azurerm_sql_database" "database" {
  name                         = "kpmgvm-db"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  server_name                  = azurerm_mssql_server.database_server.name
  edition                      = "Basic"
  requested_service_objective_name = "Basic"
  collation                    = "SQL_Latin1_General_CP1_CI_AS"
}
# connectivity between Presentation, Application & Data layers

# Create Azure Virtual Network Rule to allow access from app tier
resource "azurerm_sql_virtual_network_rule" "app_network_rule" {
  name                = "app-network-rule"
  server_name         = azurerm_mssql_server.database_server.name
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.app_subnet.id
}

# Connect the web tier to the application tier
resource "azurerm_lb_backend_address_pool" "web_backend_pool" {
  name                = "web-backend-pool"
  loadbalancer_id     = azurerm_lb.web_lb.id
  

  
}

# Connect the application tier to the database tier
resource "azurerm_virtual_machine_extension" "app_db_extension" {
  name                 = "app-db-extension"
  virtual_machine_id   = azurerm_virtual_machine.app_instances[0].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
      {
          "commandToExecute": "hostname && uptime"
      }
    SETTINGS


   tags = {
     environment = "Production"
    } 
}

variable "azure_subscription_id" {
  description = "Azure subscription ID"
}

variable "azure_client_id" {
  description = "Azure client ID"
}

variable "azure_client_secret" {
  description = "Azure client secret"
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
}

variable "storage_account_name" {
  description = "Azure Stroge account name"
}

variable "container_name" {
  description = "Azure Container name"
}

variable "key" {
  description = "Azure stroage key"
}

variable "access_key" {
  description = "Azure cotainer access key"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "kpmg-rg"
  description = "Name of the resource group."
}
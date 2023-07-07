# 3-Tier Environment for Azure Resources

This Terraform configuration creates a 3-tier environment in Azure, consisting of web, application, and database tiers. Each tier is provisioned with the necessary resources such as virtual machines, load balancers, virtual networks, and subnets.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- Azure subscription
- Terraform installed (version >= 1.0)
- Azure CLI installed and configured with your Azure account

## Deployment Steps

To deploy the 3-tier environment, follow these steps:

1. Clone the repository:

   ```shell
   git clone <repository-url>

2.Initialize the Terraform configuration:

    terraform init

3.Review the input variables in terraform.tfvars file and provide the appropriate values.

4.Run the Terraform plan to review the changes:

    terraform plan

5.Apply the changes:
   
    terraform apply
6.Wait for the deployment to complete.


Cleanup
To remove the 3-tier environment and associated resources, run the following command:

 terraform destroy

warning: Caution: This will permanently delete all the resources created by this Terraform configuration. Ensure that you have backups or any necessary data before proceeding with the destroy command.

Architecure:

                +------------------------+
                |     Frontend Tier      |
                |                        |
                |  Load Balancer (LB)    |
                |   - Public IP Address  |
                |   - Backend Pool       |
                |                        |
                |  Virtual Machines (VM) |
                |   - Web/Application   |
                |     Servers            |
                +------------------------+
                           |
                           |
                           |
                           |
                           |
               +----------------------------+
               |        Backend Tier         |
               |                            |
               |   Virtual Machines (VM)    |
               |    - Compute Resources     |
               |    - Business Logic        |
               +----------------------------+
                           |
                           |
                           |
                           |
                           |
              +-----------------------------+
              |         Database Tier        |
              |                             |
              |   Virtual Machines (VM)     |
              |    - Compute Resources      |
              |        or                   |
              |   Managed Database Service  |
              |    (e.g., Azure SQL Database)|
              +-----------------------------+


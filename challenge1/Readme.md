# Three-Tier Environment Deployment using Terraform

This repository contains Terraform code to deploy a three-tier environment on Azure. The environment consists of the following tiers:

1. Presentation Layer - Virtual machines hosting the web application
2. Application Layer - Virtual machines running the application logic
3. Data Layer - Azure SQL Database for storing application data

The infrastructure is defined using Terraform configuration files and follows a modular approach for easy management and scalability.

## Prerequisites

Before deploying the environment, ensure you have the following prerequisites:

1. Terraform version 0.12 or higher
2. Azure subscription and credentials
3. Azure CLI installed (for authentication)

## Deployment Steps

Follow the steps below to deploy the three-tier environment:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/your-repo.git
   ```

2. Change into the cloned directory:

   ```bash
   cd your-repo
   ```

3. Initialize the Terraform working directory:

   ```bash
   terraform init
   ```

4. Authenticate with Azure CLI:

   ```bash
   az login
   ```

5. Review and modify the variables in the `variables.tf` file as per your requirements.

6. Review the infrastructure plan using Terraform:

   ```bash
   terraform plan
   ```

7. Deploy the infrastructure on Azure:

   ```bash
   terraform apply
   ```

8. Confirm the deployment by typing `yes` when prompted.

The deployment process may take several minutes to provision all the required resources. Once completed, you will see the output with the provisioned resources' details.

## Cleanup

To clean up and delete the deployed resources, use the following command:

```bash
terraform destroy
```

Enter `yes` when prompted to confirm the deletion.

## Architecture

The three-tier environment is structured as follows:

1. **Presentation Layer**:
   - Load balancer (`web-lb`) distributes incoming traffic to the web virtual machines.
   - Virtual machines (`web-vm`) host the web application and serve user requests.

2. **Application Layer**:
   - Virtual machines (`app-vm`) run the application logic and connect to the database tier for data retrieval and storage.

3. **Data Layer**:
   - Azure SQL Database (`kpmgvm-db`) stores application data.
   - A virtual network rule (`app-network-rule`) allows access from the application tier to the database tier.

## Customization

To customize the deployment, you can modify the variables in the `variables.tf` file. Adjust the following parameters as needed:

- `var.resource_group_name`: Name of the Azure resource group.
- `var.resource_group_location`: Location for deploying the resources.
- Other variables related to subnet addresses, virtual machine sizes, passwords, etc.

## Contributions

Contributions to enhance the three-tier environment deployment or fix any issues are welcome. Please create a pull request with your proposed changes.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use and modify the code according to your needs.

## Acknowledgments

This deployment template was inspired by best practices and design patterns for three-tier environments on Azure.
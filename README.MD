# Homework Infrastructure

This repository contains an Azure infrastructure deployment implemented with Terragrunt and Terraform. It defines a reusable `homework_inf` module and environment-specific stage configurations for `dev`, `ppd`, and `prod`.

## Repository Structure

- `terraform/` - Terragrunt and Terraform configuration root
  - `terragrunt.hcl` - shared backend/provider generation for Azure
  - `modules/homework_inf/` - Terraform module defining Azure resources
  - `stages/` - environment-specific Terragrunt stacks
    - `dev/`
    - `ppd/`
    - `prod/`
- `.github/workflows/terraform-plan.yaml` - GitHub Actions workflow for validation and planning

## What This Project Deploys

The `homework_inf` module provisions:

- Azure Resource Group
- Azure Virtual Network and Subnet
- Network Security Group
- Log Analytics Workspace
- Azure Container Apps Environment
- Azure Container App

The Container App is deployed with environment-specific scaling and networking inputs.

## Environment Configuration

Each stage under `terraform/stages/<environment>/terragrunt.hcl`:

- includes the root `terragrunt.hcl`
- references `../../modules/homework_inf`
- sets values such as `location`, `vnet_network`, `subnet_cidr`, container image, CPU/RAM, and replica counts

### Stage differences

- `dev`: uses `10.0.0.0/16` VNet and `10.0.1.0/24` subnet
- `ppd`: uses `10.1.0.0/16` VNet and `10.1.1.0/24` subnet
- `prod`: uses `10.3.0.0/16` VNet and `10.3.1.0/24` subnet, higher CPU/RAM and replica requests

## Prerequisites

- Terraform `1.6.6`
- Terragrunt `0.67.16`
- Azure CLI or Azure OIDC login credentials
- Azure subscription with permission to create:
  - Resource groups
  - Virtual networks / subnets
  - Log Analytics workspaces
  - Azure Container Apps resources

## Local Usage

From the repository root, run Terragrunt commands inside a stage folder.

```shell
cd terraform/stages/dev
terragrunt init
terragrunt validate 
terragrunt plan 
```

For `ppd` or `prod`, replace `dev` with the appropriate stage name.

## GitHub Actions

The workflow `.github/workflows/terraform-plan.yaml` runs on `push` to `main` and on pull requests.
It validates and plans each environment (`dev`, `ppd`, `prod`) using Azure OIDC login and the configured `AZURE_*` secrets.

Required repository secrets:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

## Terraform Outputs

The module outputs:

- `vnet_id`
- `containerapps_subnet_id`
- `log_analytics_workspace_id`
- `log_analytics_workspace_name`
- `container_app_fqdn`
- `container_app_id`

## Notes

- Ingress is configured as `external_enabled = false`, so the Container App is private to the VNet for maximum security.
- The module uses `nginx:latest` by default for the container image.
- Adjust `min_replicas`, `max_replicas`, CPU, RAM, and network CIDRs per environment as needed.

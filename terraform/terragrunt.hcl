generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  content = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
EOF
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  content = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
EOF
}

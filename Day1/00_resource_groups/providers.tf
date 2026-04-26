terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mytfstate54321"
    container_name       = "tfstate"
    key                  = "00_resource_groups/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
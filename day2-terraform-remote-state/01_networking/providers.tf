terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mbftfstatestorage"
    container_name       = "tfstate"
    key                  = "mbr_prod_networking.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mytfstate54321"
    container_name       = "tfstate"
    key                  = "00_resource_groups/terraform.tfstate"
  }
}
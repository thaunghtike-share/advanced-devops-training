terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mbftfstatestorage"
    container_name       = "tfstate"
    key                  = "mbr_prod_compute.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mbftfstatestorage"
    container_name       = "tfstate"
    key                  = "mbr_prod_resource_groups.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "mbftfstatestorage"
    container_name       = "tfstate"
    key                  = "mbr_prod_networking.tfstate"
  }
}
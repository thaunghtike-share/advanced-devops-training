resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-lifecycle-demo"
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = "stlife${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }

  lifecycle {
    prevent_destroy = false

    ignore_changes = [
      tags
    ]
  }
}

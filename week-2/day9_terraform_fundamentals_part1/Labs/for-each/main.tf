resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-foreach-demo"
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  for_each = var.storage_accounts

  name                     = "st${each.key}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = each.value
  account_replication_type = "LRS"

  tags = {
    Environment = each.key
  }
}

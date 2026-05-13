resource "azurerm_resource_group" "rg" {
  count = var.create_rg ? 1 : 0

  name     = "rg-conditional-count-demo"
  location = var.location
}

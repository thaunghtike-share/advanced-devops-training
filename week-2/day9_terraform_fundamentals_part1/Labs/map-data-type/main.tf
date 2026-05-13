resource "azurerm_resource_group" "rg" {
  name     = "rg-map-demo"
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "rg" {
  count = length(var.locations)

  name     = "rg-list-${count.index}"
  location = var.locations[count.index]
}

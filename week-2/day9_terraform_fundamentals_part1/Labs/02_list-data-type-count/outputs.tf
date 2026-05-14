output "resource_group_names" {
  value = azurerm_resource_group.rg[*].name
}

output "resource_group_locations" {
  value = azurerm_resource_group.rg[*].location
}

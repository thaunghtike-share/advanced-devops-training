output "current_workspace" {
  value = terraform.workspace
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

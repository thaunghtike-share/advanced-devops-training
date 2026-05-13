output "name_prefix" {
  value = local.name_prefix
}

output "common_tags" {
  value = local.common_tags
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

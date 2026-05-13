output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "environment" {
  value = var.environment
}

output "instance_count" {
  value = var.instance_count
}

output "enable_logging" {
  value = var.enable_logging
}

output "resource_group_created" {
  value = var.create_rg
}

output "resource_group_name" {
  value = var.create_rg ? azurerm_resource_group.rg[0].name : "resource group not created"
}

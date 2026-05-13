output "resource_groups" {
  description = "A map of all resource group attributes indexed by their key."
  value       = azurerm_resource_group.mbr_rg
}
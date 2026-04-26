################################################################################
# RESOURCE GROUP DATA
#
# This output creates a single lookup table. 
# Usage in other layers: 
#   - outputs.resource_groups["my-rg"].name
#   - outputs.resource_groups["my-rg"].location
################################################################################

output "resource_groups" {
  description = "A map of all resource group attributes indexed by their key."
  value       = azurerm_resource_group.mbr_rg
}
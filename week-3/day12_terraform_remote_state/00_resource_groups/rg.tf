resource "azurerm_resource_group" "mbr_rg" {
  for_each = var.resource_groups

  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}
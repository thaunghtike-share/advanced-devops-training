resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_prefix}"
  location = var.location

  tags = local.common_tags
}

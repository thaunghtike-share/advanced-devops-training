resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = each.key
  location            = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name
  address_space       = each.value.address_space
  tags                = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].tags
}

locals {
  vnet_subnets = flatten([
    for vnet_key, vnet_val in var.vnets : [
      for snet_key, snet_val in vnet_val.subnets : {
        vnet_name = vnet_key
        snet_name = snet_key
        prefixes  = snet_val.address_prefixes
        # Use try() to handle missing attributes in the map
        service_endpoints = try(snet_val.service_endpoints, [])
      }
    ]
  ])
}

resource "azurerm_subnet" "subnet" {
  for_each             = { for s in local.vnet_subnets : "${s.vnet_name}.${s.snet_name}" => s }
  name                 = each.value.snet_name
  resource_group_name  = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_name].name
  address_prefixes     = each.value.prefixes
  service_endpoints    = each.value.service_endpoints
}
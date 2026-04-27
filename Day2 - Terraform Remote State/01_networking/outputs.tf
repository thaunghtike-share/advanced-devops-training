output "vnet_ids" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "subnet_ids" {
  value = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "vnets" {
  value = azurerm_virtual_network.vnet
}

output "subnets" {
  value = azurerm_subnet.subnet
}
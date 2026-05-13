output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "rules" {
  value = local.nsg_rules
}

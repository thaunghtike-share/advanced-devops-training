output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "storage_accounts" {
  value = {
    for key, value in azurerm_storage_account.sa : key => value.name
  }
}

output "storage_account_names" {
  value = {
    for key, value in azurerm_storage_account.sa : key => value.name
  }
}

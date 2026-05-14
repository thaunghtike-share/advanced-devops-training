output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary Blob Endpoint of the Storage Account"
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}
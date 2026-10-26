/* output "resource_group_id" {
    value = azurerm_resource_group.rg.id
} */

output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Used by upload command and pipeline"
}
/*
output "storage_account_id" {
    value = azurerm_storage_account.sa.id
}*/

output "storage_account_name" {
  value       = azurerm_storage_account.sa.name
  description = "Used by upload command and pipeline"
}

output "website_url" {
  value       = azurerm_storage_account.sa.primary_web_endpoint
  description = "Public URL of site"
}

output "subscription_id" {
  value       = data.azurerm_client_config.current.subscription_id
  description = "Used for finding subscription ID"
}
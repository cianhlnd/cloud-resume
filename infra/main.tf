resource "random_string" "suffix" {
  length  = 6
  special = false
  numeric = true
  upper   = false
  lower   = false
}


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.resume_tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.resume_tags
}

resource "azurerm_storage_account_static_website" "static_website" {
  storage_account_id = azurerm_storage_account.sa.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

data "azurerm_client_config" "current" {
}

resource "azurerm_role_assignment" "sa_blob_data_contributor" {
  for_each = var.object_ids

  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
  scope                = azurerm_storage_account.sa.id
}

##moved {
  ##from = azurerm_role_assignment.sa_blob_data_contributor
  ##to   = azurerm_role_assignment.sa_blob_data_contributor["my_id"]
##}
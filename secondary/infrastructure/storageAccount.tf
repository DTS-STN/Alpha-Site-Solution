resource "random_string" "storageName-secondary" {
  length           = 16
  special          = false
}

resource "azurerm_storage_account" "appservice-diagnostics-secondary" {
  name                     = lower(random_string.storageName-secondary.result)
  resource_group_name      = var.depot_resource_group
  location                 = var.backup_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_cosmosdb_account" "cosmosdb-account" {
  name                = "${var.application_name}-cosmosdb-account-${var.environment}"
  location            = var.location
  resource_group_name = var.database_resource_group
  offer_type          = "Standard"
  kind                = "MongoDB"
  mongo_server_version = "4.0"

  enable_automatic_failover = false
  is_virtual_network_filter_enabled  = false
  ip_range_filter = "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  backup {
    type = "Periodic"
    interval_in_hours = 12
    retention_in_hours = 720
  }
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb-mongo" {
  name                = "researchpool"
  resource_group_name = var.database_resource_group
  account_name        = azurerm_cosmosdb_account.cosmosdb-account.name
  throughput          = 400
}

resource "azurerm_key_vault_secret" "cosmosdb-uri" {
  name    = "mongo-uri"
  value   = azurerm_cosmosdb_account.cosmosdb-account.connection_strings[0]
  key_vault_id = var.keyvault_id
}
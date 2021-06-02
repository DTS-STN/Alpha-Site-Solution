resource "azurerm_cosmosdb_account" "cosmosdb-account" {
  name                = "cosmosdb-account-${var.environment}"
  location            = var.location
  resource_group_name = var.database_resource_group
  offer_type          = "Standard"
  kind                = "MongoDB"

  enable_automatic_failover = false

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
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb-mongo" {
  name                = "cosmosdb-mongo-${var.environment}"
  resource_group_name = var.database_resource_group
  account_name        = azurerm_cosmosdb_account.cosmosdb-account.name
  throughput          = 400
}


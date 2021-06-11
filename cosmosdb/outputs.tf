output "mongoUri" {
   value = azurerm_cosmosdb_account.cosmosdb-account.connection_strings
   sensitive   = true
}

output "mongoDB" {
   value = azurerm_cosmosdb_mongo_database.cosmosdb-mongo.name
}

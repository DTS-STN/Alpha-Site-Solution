output "mongoUri" {
   value = azurerm_key_vault_secret.cosmosdb-uri.value
   sensitive   = true
}

output "mongoDB" {
   value = azurerm_cosmosdb_mongo_database.cosmosdb-mongo.name
}

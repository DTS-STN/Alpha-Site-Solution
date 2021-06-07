output "mongoUri" {
   value = azurerm_cosmosdb_account.cosmosdb-account.connection_strings
   sensitive   = true
}

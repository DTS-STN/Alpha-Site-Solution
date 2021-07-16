resource "random_password" "pgsql-db-pass" {
  length = 16
  special = false
}

resource "azurerm_key_vault_secret" "pgsql-db-pass" {
  name     = "pgsql-db-pass"
  value    = random_password.pgsql-db-pass.result
  key_vault_id = var.keyvault_id
}

resource "azurerm_postgresql_server" "pgsql-server" {
  name                = "${var.application_name}-pgserver-${var.environment}"
  location            = var.location
  resource_group_name = var.database_resource_group

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "alphasiteDbAdmin"
  administrator_login_password = azurerm_key_vault_secret.pgsql-db-pass.value
  version                      = "11"
  ssl_enforcement_enabled      = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "pgsql-db" {
  name                = "pgsqldb${var.environment}"
  resource_group_name = var.database_resource_group
  server_name         = azurerm_postgresql_server.pgsql-server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
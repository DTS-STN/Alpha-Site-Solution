data "azurerm_postgresql_server" "pgsql-server" {
  name                = azurerm_postgresql_server.pgsql-server.name
  resource_group_name = var.database_resource_group
}

output "pgsql-server-fqdn" {
    value = data.azurerm_postgresql_server.pgsql-server.fqdn
}

output "pgsql-server-login" {
    value = data.azurerm_postgresql_server.pgsql-server.administrator_login
}

output "pgsql-server-name" {
    value = azurerm_postgresql_server.pgsql-server.name
}

output "pgsqlDbPass" {
  value = azurerm_key_vault_secret.pgsql-db-pass.value
}

output "pgsql-db-name" {
    value = azurerm_postgresql_database.name
}
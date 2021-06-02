resource "azurerm_key_vault" "keyvault" {
  name                        = "keyvault-${var.environment}"
  location                    = var.location
  resource_group_name         = var.depot_resource_group
  tenant_id                   = var.tenant_id

  sku_name = "standard"
 
}

resource "azurerm_key_vault_secret" "terraform-pass" {
  name     = "terraform-pass-${var.environment}"
  value    = var.client_secret
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "random_password" "pgsql-db-pass" {
  length = 16
  special = false
}

resource "azurerm_key_vault_secret" "pgsql-db-pass" {
  name     = "pgsql-db-pass"
  value    = random_password.pgsql-db-pass.result
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "random_password" "strapi-admin-jwt-secret" {
  length = 32
  special = false
}

resource "azurerm_key_vault_secret" "strapi-admin-jwt-secret" {
  name     = "strapi-admin-jwt-secret"
  value    = random_password.strapi-admin-jwt-secret.result
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret "cosmosdb-uri" {
  name    = "cosmosdb-uri"
  value   = var.cosmosdb-uri
  key_vault_id = azurerm_key_vault.keyvault.id
}

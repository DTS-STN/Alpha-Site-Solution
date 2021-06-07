resource "random_password" "strapi-admin-jwt-secret" {
  length = 32
  special = false
}

resource "azurerm_key_vault_secret" "strapi-admin-jwt-secret" {
  name     = "strapi-admin-jwt-secret"
  value    = random_password.strapi-admin-jwt-secret.result
  key_vault_id = var.keyvault_id
}
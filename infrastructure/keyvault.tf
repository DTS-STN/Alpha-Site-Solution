resource "azurerm_key_vault" "keyvault" {
  name                        = "${prefix}-keyvault-${var.environment}"
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
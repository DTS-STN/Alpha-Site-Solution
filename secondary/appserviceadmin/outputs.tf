output "secondaryAdminAppServiceHostname" {
  value = azurerm_app_service.app-service-admin-secondary.default_site_hostname
}
output "strapiJWT" {
  value = azurerm_key_vault_secret.strapi-admin-jwt-secret.value
}
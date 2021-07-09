output "primaryAdminAppServiceHostname" {
  value = azurerm_app_service.app-service-admin-primary.default_site_hostname
}
output "strapiJWT" {
  value = azurerm_key_vault_secret.strapi-admin-jwt-secret.value
  sensitive = true
}
output "adminAppServicePlanId" {
  value = azurerm_app_service_plan.app-service-plan-admin.id
}
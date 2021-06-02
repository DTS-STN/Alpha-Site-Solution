output "primaryAdminAppServiceName" {
  value = azurerm_app_service.app-service-admin-primary.name
}
output "secondaryAdminAppServiceName" {
  value = azurerm_app_service.app-service-admin-secondary.name
}
output "primaryAdminAppServiceHostname" {
  value = azurerm_app_service.app-service-admin-primary.default_site_hostname
}
output "secondaryAdminAppServiceHostname" {
  value = azurerm_app_service.app-service-admin-secondary.default_site_hostname
}
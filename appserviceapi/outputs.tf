output "primaryApiAppServiceName" {
  value = azurerm_app_service.app-service-api-primary.name
}
output "secondaryApiAppServiceName" {
  value = azurerm_app_service.app-service-api-secondary.name
}
output "primaryApiAppServiceHostname" {
  value = azurerm_app_service.app-service-api-primary.default_site_hostname
}
output "secondaryApiAppServiceHostname" {
  value = azurerm_app_service.app-service-api-secondary.default_site_hostname
}
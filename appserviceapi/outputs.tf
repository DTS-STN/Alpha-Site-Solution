output "primaryApiAppServiceHostname" {
  value = azurerm_app_service.app-service-api-primary.default_site_hostname
}
output "stagingApiAppServiceHostname" {
  value = azurerm_app_service_slot.app-service-api-primary.default_site_hostname
}
output "primaryAppServiceHostname" {
  value = azurerm_app_service.app-service-primary.default_site_hostname
}
output "stagingAppServiceHostname" {
  value = azurerm_app_service_slot.app-service-primary.default_site_hostname
}

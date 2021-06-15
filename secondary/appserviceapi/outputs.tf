output "secondaryApiAppServiceHostname" {
  value = azurerm_app_service.app-service-api-secondary.default_site_hostname
}
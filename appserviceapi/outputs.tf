output "primaryApiAppServiceHostname" {
  value = azurerm_app_service.app-service-api-primary.default_site_hostname
}
output "primaryAppServiceHostname" {
  value = azurerm_app_service.app-service-primary.default_site_hostname
}
output "primaryAppServicePlanId" {
  value = azurerm_app_service_plan.app-service-plan-primary.id
}
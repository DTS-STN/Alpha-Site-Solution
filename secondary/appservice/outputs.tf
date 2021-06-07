output "secondaryAppServiceHostname" {
  value = azurerm_app_service.app-service-secondary.default_site_hostname
}
output "secondaryAppServicePlanId" {
  value = azurerm_app_service_plan.app-service-plan-secondary.id
}

 
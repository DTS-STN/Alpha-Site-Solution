output "primaryAppServiceName" {
  value = azurerm_app_service.app-service-primary.name
}
output "secondaryAppServiceName" {
  value = azurerm_app_service.app-service-secondary.name
}
output "primaryAppServiceHostname" {
  value = azurerm_app_service.app-service-primary.default_site_hostname
}
output "secondaryAppServiceHostname" {
  value = azurerm_app_service.app-service-secondary.default_site_hostname
}
output "primaryAppServicePlanId" {
  value = azurerm_app_service_plan.app-service-plan-primary.id
}
output "secondaryAppServicePlanId" {
  value = azurerm_app_service_plan.app-service-plan-secondary.id
}

 
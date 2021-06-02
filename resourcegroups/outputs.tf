output "appServiceRgName" {
  value = azurerm_resource_group.appService.name
}
output "location" {
  value = azurerm_resource_group.appService.location
}
output "networkRgName" {
  value = azurerm_resource_group.network.name
}
output "databaseRgName" {
  value = azurerm_resource_group.database.name
}
output "depotRgName" {
  value = azurerm_resource_group.depot.name
}

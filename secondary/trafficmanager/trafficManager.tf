resource "azurerm_traffic_manager_endpoint" "tm-endpoint-secondary" {
  name                = "tm-endpoint-secondary"
  resource_group_name = var.network_resource_group
  profile_name        = azurerm_traffic_manager_profile.traffic-manager.name
  type                = "externalEndpoints"
  target              = var.secondary_public_ip_fqdn
  endpoint_location   = var.backup_location
}
output "vnetId" {
  value = azurerm_virtual_network.appservice_vnet.id
}
output "vnetId_secondary" {
  value = azurerm_virtual_network.appservice_vnet_secondary.id
}
output "publicIpId_primary" {
    value = azurerm_public_ip.appgateway_publicip_primary.id
}
output "publicIpFqdn_primary" {
    value = azurerm_public_ip.appgateway_publicip_primary.fqdn
}
output "publicIpId_secondary" {
    value = azurerm_public_ip.appgateway_publicip_secondary.id
}
output "publicIpFqdn_secondary" {
    value = azurerm_public_ip.appgateway_publicip_secondary.fqdn
}
output "subnetId" {
  value = azurerm_subnet.frontend.id
}
output "subnetId_secondary" {
  value = azurerm_subnet.frontend_secondary.id
}
output "dockerRegistryLogin" {
  value = azurerm_container_registry.acr.login_server
}
output "dockerRegistryUsername" {
  value = azurerm_container_registry.acr.admin_username
}
output "dockerRegistryPassword" {
  value = azurerm_container_registry.acr.admin_password
}
output "keyvaultID" {
  value = azurerm_key_vault.keyvault.id
}

output "diagnosticStorageAccountId" {
  value = azurerm_storage_account.appservice-diagnostics.id
}
output "diagnosticStorageAccountId_secondary" {
  value = azurerm_storage_account.appservice-diagnostics-secondary.id
}
output "alphasiteStorageAccountName" {
  value = azurerm_storage_account.storageacct.name
}
output "alphasiteStorageAccountKey" {
  value = azurerm_storage_account.storageacct.primary_access_key
}
output "alphasiteStorageAccountUrl" {
  value = azurerm_storage_account.storageacct.primary_blob_endpoint
}
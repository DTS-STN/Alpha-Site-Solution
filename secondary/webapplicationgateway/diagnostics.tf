resource "azurerm_monitor_diagnostic_setting" "application-secondary-diagnostics" {
  name                = "ag-diagnostics-secondary"
  target_resource_id = azurerm_application_gateway.application-gateway-v2-secondary.id
  storage_account_id = var.secondary_diagnostic_storage_account_id


log {
    category = "ApplicationGatewayAccessLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

log {
    category = "ApplicationGatewayPerformanceLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  
log {
    category = "ApplicationGatewayFirewallLog"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}
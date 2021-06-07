resource "azurerm_monitor_diagnostic_setting" "as-admin-secondary-diagnostics" {
  name               = "admin-diagnostics-${var.environment}-${var.backup_location}"
  target_resource_id = azurerm_app_service.app-service-admin-secondary.id
  storage_account_id = var.diagnostic_storage_account_id_secondary



log {
    category = "AppServiceAntivirusScanAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  
log {
    category = "AppServiceConsoleLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  
log {
    category = "AppServiceAppLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

log {
    category = "AppServiceFileAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  
log {
    category = "AppServiceAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }    
log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }  
log {
    category = "AppServicePlatformLogs"
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
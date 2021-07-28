resource "azurerm_monitor_diagnostic_setting" "as-admin-primary-diagnostics" {
  name               = "admin-diagnostics-${var.environment}-${var.location}"
  target_resource_id = azurerm_app_service.app-service-admin-primary.id
  storage_account_id = var.diagnostic_storage_account_id



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

resource "azurerm_application_insights" "as-admin-primary-appinsight" {
  name    = "appinsight-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = var.appservice_resource_group
  application_type    = "Node.JS"
}

output "instrumentation_key" {
  value = azurerm_application_insights.as-admin-primary-appinsight.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.as-admin-primary-appinsight.app_id
}
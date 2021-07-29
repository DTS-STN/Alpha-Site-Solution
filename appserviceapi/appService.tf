# Create App Services
variable instrumentation_key{
  type = string
}
resource "azurerm_app_service" "app-service-api-primary" {
  name                = "api-appservice-${var.environment}"
  location            = var.location
  resource_group_name = var.appservice_resource_group
  app_service_plan_id = var.admin_app_service_plan_id
  https_only          = true

  site_config {
    always_on = "true"

    linux_fx_version  = "DOCKER|${var.docker_registry}/${var.api_docker_container}" #define the images to use for your application

    health_check_path = var.healthcheck_page # health check required in order that internal app service plan loadbalancer do not loadbalance on instance down

    ip_restriction {
      virtual_network_subnet_id  = var.subnet_id
      priority = 301
    }

  }


  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=${var.instrumentation_key}",
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0",
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0",
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = "",
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3",
    "DiagnosticServices_EXTENSION_VERSION"            = "~3",
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled",
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled",
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled",
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended",
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled",

    "APP_SERVICE" = "true"
    "DOCKER_REGISTRY_SERVER_URL" = var.docker_registry
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_registry_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_registry_password
    "SLOT_NAME" = "default"
    "DATABASE_HOST" = var.database_host
    "DATABASE_PORT" = var.database_port
    "DATABASE_NAME" = var.database_name
    "DATABASE_USERNAME" = "${var.database_login}@${var.database_server}"
    "DATABASE_PASSWORD" = var.database_pass
    "DATABASE_SSL" = true
    "STRAPI_API_BACKEND_URL" = var.api_url
    "STRAPI_API_HOST" = "0.0.0.0" 
    "STRAPI_API_PORT" = var.api_port
    "STRAPI_STORAGE" = "azure"
    "STORAGE_ACCOUNT" = var.cms_storage_account_name
    "STORAGE_ACCOUNT_KEY" = var.cms_storage_account_key
    "STORAGE_ACCOUNT_URL" = var.cms_storage_account_url
    "STORAGE_ACCOUNT_CONTAINER" = var.application_name
    "STRAPI_ADMIN_JWT_SECRET" = var.strapi_admin_jwt_secret
  }

}

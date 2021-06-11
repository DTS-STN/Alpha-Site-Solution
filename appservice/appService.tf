# Create App Service Plans
resource "azurerm_app_service_plan" "app-service-plan-primary" {
  name                = "asp-${var.environment}-${var.location}"
  kind                = "Linux"
  reserved            = true
  location            = var.location
  resource_group_name = var.appservice_resource_group

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "app-service-plan-secondary" {
  name                = "asp-${var.environment}-${var.backup_location}"
  kind                = "Linux"
  reserved            = true
  location            = var.backup_location
  resource_group_name = var.appservice_resource_group

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create App Services
resource "azurerm_app_service" "app-service-primary" {
  name                = "as-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = var.appservice_resource_group
  app_service_plan_id = azurerm_app_service_plan.app-service-plan-primary.id
  https_only          = true

  site_config {
    always_on = "true"

    linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_container}" #define the images to usecfor you application

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
    "APP_SERVICE"                     = "true"
    "DOCKER_REGISTRY_SERVER_URL"      = var.docker_registry
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_registry_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_registry_password
    "SLOT_NAME"                       = "default"
    "REPORT_A_PROBLEM_ENABLED"        = "true"
    "USER_SIGNUP_ENABLED"             = "true"
    "USER_SIGNUP_FRENCH_TEMPLATE_ID"  = var.USER_SIGNUP_FRENCH_TEMPLATE_ID
    "USER_SIGNUP_ENGLISH_TEMPLATE_ID" = var.USER_SIGNUP_ENGLISH_TEMPLATE_ID
    "NOTIFY_BASE_API_URL"             = var.NOTIFY_BASE_API_URL
    "NOTIFY_API_KEY"                  = var.NOTIFY_API_KEY
    "NOTIFY_REPORT_A_PROBLEM_EMAIL"   = var.NOTIFY_REPORT_A_PROBLEM_EMAIL
    "NOTIFY_REPORT_A_PROBLEM_TEMPLATE_ID" = var.NOTIFY_REPORT_A_PROBLEM_TEMPLATE_ID
    "MONGO_URL"                       = var.MONGO_URL
    "MONGO_DB"                        = var.MONGO_DB
  }

}

resource "azurerm_app_service" "app-service-secondary" {
  name                = "as-${var.environment}-${var.backup_location}"
  location            = var.backup_location
  resource_group_name = var.appservice_resource_group
  app_service_plan_id = azurerm_app_service_plan.app-service-plan-secondary.id
  https_only          = true

  site_config {
    always_on = "true"

    linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_container}" #define the images to usecfor you application

    health_check_path = var.healthcheck_page # health check required in order that internal app service plan loadbalancer do not loadbalance on instance down

    ip_restriction {
      virtual_network_subnet_id  = var.subnet_id_secondary
      priority = 301
    }

  }


  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "APP_SERVICE"                     = "true"
    "DOCKER_REGISTRY_SERVER_URL"      = var.docker_registry
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_registry_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_registry_password
    "SLOT_NAME"                       = "default"
    "REPORT_A_PROBLEM_ENABLED"        = "true"
    "USER_SIGNUP_ENABLED"             = "true"
    "USER_SIGNUP_FRENCH_TEMPLATE_ID"  = var.USER_SIGNUP_FRENCH_TEMPLATE_ID
    "USER_SIGNUP_ENGLISH_TEMPLATE_ID" = var.USER_SIGNUP_ENGLISH_TEMPLATE_ID
    "NOTIFY_BASE_API_URL"             = var.NOTIFY_BASE_API_URL
    "NOTIFY_API_KEY"                  = var.NOTIFY_API_KEY
    "NOTIFY_REPORT_A_PROBLEM_EMAIL"   = var.NOTIFY_REPORT_A_PROBLEM_EMAIL
    "NOTIFY_REPORT_A_PROBLEM_TEMPLATE_ID" = var.NOTIFY_REPORT_A_PROBLEM_TEMPLATE_ID
    "MONGO_URL"                       = var.MONGO_URL
    "MONGO_DB"                        = var.MONGO_DB

  }

}
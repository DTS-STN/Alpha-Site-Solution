resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_app_service_slot" "app-service-primary" {
    name                    = random_id.server.hex
    app_service_name        = azurerm_app_service.app-service-primary.name
    location                = var.location
    resource_group_name     = var.appservice_resource_group
    app_service_plan_id     = azurerm_app_service_plan.app-service-plan-primary.id
    https_only              = true
    client_affinity_enabled = true

    site_config {
        always_on = "true"

        linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_container}"

        health_check_path = var.healthcheck_page # health check required in order that internal app service plan loadbalancer do not loadbalance on instance down
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

    }

}

resource "azurerm_app_service_slot" "app-service-secondary" {
    name                    = random_id.server.hex
    app_service_name        = azurerm_app_service.app-service-secondary.name
    location                = var.backup_location
    resource_group_name     = var.appservice_resource_group
    app_service_plan_id     = azurerm_app_service_plan.app-service-plan-secondary.id
    https_only              = true
    client_affinity_enabled = true

    site_config {
        always_on = "true"

        linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_container}"

        health_check_path = var.healthcheck_page # health check required in order that internal app service plan loadbalancer do not loadbalance on instance down
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

    }

}
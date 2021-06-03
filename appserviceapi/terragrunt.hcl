include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "../resourcegroups"
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}

dependency "appService" {
  config_path = "../appservice"
}

dependency "appServiceAdmin" {
  config_path = "../appserviceadmin"
}

dependency "pgsql" {
  config_path = "../pgsql"
}

inputs = merge({
    appservice_resource_group   = dependency.resourceGroups.outputs.appServiceRgName
    location  = dependency.resourceGroups.outputs.location
    subnet_id   = dependency.infrastructure.outputs.subnetId
    subnet_id_secondary   = dependency.infrastructure.outputs.subnetId_secondary
    diagnostic_storage_account_id = dependency.infrastructure.outputs.diagnosticStorageAccountId
    secondary_diagnostic_storage_account_id = dependency.infrastructure.outputs.diagnosticStorageAccountId_secondary
    app_service_plan_id = dependency.appService.outputs.primaryAppServicePlanId
    database_pass = dependency.pgsql.outputs.pgsqlDbPass
    database_host = dependency.pgsql.outputs.pgsql-server-fqdn
    database_login = dependency.pgsql.outputs.pgsql-server-login
    database_server = dependency.pgsql.outputs.pgsql-server-name
    database_name = dependency.pgsql.outputs.pgsql-db-name
    storage_account_name = dependency.infrastructure.outputs.alphasiteStorageAccountName
    storage_account_key = dependency.infrastructure.outputs.alphasiteStorageAccountKey
    storage_account_url = dependency.infrastructure.outputs.alphasiteStorageAccountUrl
    docker_registry = dependency.infrastructure.outputs.dockerRegistryLogin
    docker_registry_username = dependency.infrastructure.outputs.dockerRegistryUsername
    docker_registry_password = dependency.infrastructure.outputs.dockerRegistryPassword
    strapi_admin_jwt_secret = dependency.appServiceAdmin.outputs.strapiJWT
})

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply", "import", "destroy"]
    arguments = local.varfile != null ? ["-var-file=${local.varfile}"] : []
  }

  before_hook "copy_parent_variables" {
    commands     = ["apply", "plan", "import", "destroy"]
    execute      = ["cp", "../variables.tf", "."]
  }

  after_hook "remove_parent_variables" {
    commands     = ["apply", "plan", "import", "destroy"]
    execute      = ["rm", "./variables.tf"]
    run_on_error = true
  }  
}

locals {
  varfile = "${get_parent_terragrunt_dir()}/${get_env("TG_VAR_FILE")}"
  vardata = local.varfile != null ? jsondecode(file(local.varfile)) : { } # some default
}
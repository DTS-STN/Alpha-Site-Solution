include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "../../resourcegroups"
}
dependency "infrastructure" {
  config_path = "../../infrastructure"
}
dependency "appService" {
  config_path = "../../appservice"
}
dependency "appServiceAdmin" {
  config_path = "../../appserviceadmin"
}
dependency "appServiceAPI" {
  config_path = "../../appserviceapi"
}


inputs = merge({
  network_resource_group  = dependency.resourceGroups.outputs.networkRgName
  location  = dependency.resourceGroups.outputs.location
  subnet_id_secondary   = dependency.infrastructure.outputs.subnetId_secondary
  vnet_id_secondary  = dependency.infrastructure.outputs.vnetId_secondary
  secondary_public_ip_fqdn = dependency.infrastructure.outputs.publicIpFqdn_secondary
  public_ip_id_secondary = dependency.infrastructure.outputs.publicIpId_secondary
  secondary_application_appservice_hostname = dependency.appService.outputs.secondaryAppServiceHostname
  secondary_admin_appservice_hostname = dependency.appServiceAdmin.outputs.secondaryAdminAppServiceHostname
  secondary_api_appservice_hostname = dependency.appServiceAPI.outputs.secondaryApiAppServiceHostname
  secondary_diagnostic_storage_account_id = dependency.infrastructure.outputs.diagnosticStorageAccountId_secondary
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

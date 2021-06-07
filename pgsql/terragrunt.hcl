include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "../resourcegroups"
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}

inpts = merge({  
  resource_group_name   = dependency.resourceGroups.outputs.databaseRgName
  location  = dependency.resourceGroups.outputs.location
  subnet_id   = dependency.infrastructure.outputs.databasePass
  subnet_id_secondary   = dependency.infrastructure.outputs.subnetId_secondary
  diagnostic_storage_account_id = dependency.infrastructure.outputs.diagnosticStorageAccountId
  secondary_diagnostic_storage_account_id = dependency.infrastructure.outputs.diagnosticStorageAccountId_secondary
  database_pass = dependency.infrastructure.outputs.pgsqlDbPass
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
include {
  path = find_in_parent_folders()
}

dependency "resourceGroups" {
  config_path = "../../resourcegroups"
}

dependency "infrastructure" {
  config_path = "../../infrastructure"
}

inputs = merge({
    network_resource_group   = dependency.resourceGroups.outputs.networkRgName
    location  = dependency.resourceGroups.outputs.location
    secondary_public_ip_fqdn = dependency.infrastructure.outputs.publicIpFqdn_secondary
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
  vardata = local.varfile != null ? jsondecode(file(local.varfile)) : {  } # some default
}
resource "random_string" "storageName" {
  length           = 16
  special          = false
}

resource "azurerm_storage_account" "appservice-diagnostics" {
  name                     = lower(random_string.storageName.result)
  resource_group_name      = var.depot_resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "random_string" "storageName-secondary" {
  length           = 16
  special          = false
}

resource "azurerm_storage_account" "appservice-diagnostics-secondary" {
  name                     = lower(random_string.storageName-secondary.result)
  resource_group_name      = var.depot_resource_group
  location                 = var.backup_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_account" "depot-storageacct" {
  name                     = var.remote_state_storage_account_name
  resource_group_name      = var.depot_resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Environment = var.environment_tag
    Terraform = "True"
    Branch = "Innovation, Information and Technology"
    Classification = "Unclassified"
    Directorate = "Business Solutions and Information Management"
    ProjectName = "Digital Technology Solutions"
    ProductOwner = "Dwayne Moore - Digital Technology Solutions"
    RequesterEmail = "gocmts@gmail.com"
    OvernightShutdown = false
    Department = "Employment and Social Development Canada"
    Division = ""
    Section = ""
    ProjectID = ""
    CsdID = ""
  }
}

resource "azurerm_storage_account" "storageacct" {
  name                     = "${var.application_name}blobstorage${var.environment}"
  resource_group_name      = var.depot_resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Environment = var.environment_tag
    Terraform = "True"
    Branch = "Innovation, Information and Technology"
    Classification = "Unclassified"
    Directorate = "Business Solutions and Information Management"
    ProjectName = "Digital Technology Solutions"
    ProductOwner = "Dwayne Moore - Digital Technology Solutions"
    RequesterEmail = "gocmts@gmail.com"
    OvernightShutdown = false
    Department = "Employment and Social Development Canada"
    Division = ""
    Section = ""
    ProjectID = ""
    CsdID = ""
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "alphasite"
  storage_account_name  = azurerm_storage_account.storageacct.name
  container_access_type = "private"
}
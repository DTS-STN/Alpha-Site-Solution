resource "azurerm_resource_group "network" {
  name = "${var.subscription_name}AlphasiteNetworkRG"
  location = var.location
}

resource "azurerm_resource_group "database" {
  name = "${var.subscription_name}AlphasiteDatabaseRG"
  location = var.location
}

resource "azurerm_resource_group "appService" {
  name = "${var.subscription_name}AlphasiteAppServiceRG"
  location = var.location
}

resource "azurerm_resource_group" "depot" {
  name     = "${var.subscription_name}AlphasiteDepotRG"
  location = var.location
}
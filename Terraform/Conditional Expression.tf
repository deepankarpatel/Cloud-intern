provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Expression" {
    name = "COnditionRG"
    location = "Central India"
}

variable "istest" {}

resource "azurerm_lb" "dev" {
  name = "DevLB"
  resource_group_name = azurerm_resource_group.Expression.name
  location = azurerm_resource_group.Expression.location
  count = var.istest == true? 1 : 0
}

resource "azurerm_lb" "Prod" {
  name = "ProdLB"
  resource_group_name = azurerm_resource_group.Expression.name
  location = azurerm_resource_group.Expression.location
  count = var.istest == false ? 1 : 0
}

/*
In this code there is two loadbalancers dev and prod we use conditional expression to create the loadbalancer
one by one. In this if the value is true the dev LB is created and if the value is false the prod LB is created
*/
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "LocalValue" {
  name = "myRG"
  location = "central india"
}

locals {
  common_tags = {
    owner  = "Special Ops"
    service = "backend"
  }
}

resource "azurerm_lb" "devLB" {
  name = "DevLB"
  resource_group_name = azurerm_resource_group.LocalValue.name
  location = azurerm_resource_group.LocalValue.location
  tags = local.common_tags

}

resource "azurerm_lb" "ProdLB" {
  name = "DevLB"
  resource_group_name = azurerm_resource_group.LocalValue.name
  location = azurerm_resource_group.LocalValue.location
  tags = local.common_tags
}

resource "azurerm_virtual_network" "MyVnet" {
  name = "vnet"
  resource_group_name = azurerm_resource_group.LocalValue.name
  location = azurerm_resource_group.LocalValue.location
  address_space = ["10.0.0.0/16"]
  tags = local.common_tags
}


#In this code we uses the locals to define the tags 

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myRg" {
  name = "LoadsOfHeaven"
  location = "central india"
}

variable "myVar" {
  type = set(string)
  default = [ "Load-01", "Load-02", "Load-03" ]
}

resource "azurerm_lb" "MyLB" {
  resource_group_name = azurerm_resource_group.myRg.name
  location = azurerm_resource_group.myRg.location
  for_each = var.myVar
  name = each.key
}
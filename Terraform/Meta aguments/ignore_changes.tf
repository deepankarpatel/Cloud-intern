provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Myrg" {
  name     = "MetaArgument"
  location = "central india"
}

resource "azurerm_lb" "Load" {
  name                = "MyLB"
  resource_group_name = azurerm_resource_group.Myrg.name
  location            = azurerm_resource_group.Myrg.location


  tags = {
    name = "Hello world"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

#this code is ignoring the manually added change in the tags in the loadbalancer 
#with meta argument lyfecycle "ignore changes"


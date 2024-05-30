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
    prevent_destroy = true
  }
}

#this prevent_destory meta argument will prevent the resource from destroying
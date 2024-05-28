provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "myRg" {
  name = "newVM"
}

resource "azurerm_lb" "set" {
  name                = "my_lb"
  resource_group_name = data.azurerm_resource_group.myRg.name
  location            = data.azurerm_resource_group.myRg.location
}

/*
In this we used terraform taint command, in this the command delete the origional resource and create 
same and new resource with terraform configuration file
for example => terraform apply -replace="azurerm_lb.set" this command will delete origional loadbalancer and 
create new loadbalancer with same configuration
*/
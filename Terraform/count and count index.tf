provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "LoadGroup" {
  name     = "LoadBalancerRG"
  location = "Central india"
}


resource "azurerm_lb" "MyLB" {
  name                = "LoadBalancer${count.index}"
  location            = azurerm_resource_group.LoadGroup.location
  resource_group_name = azurerm_resource_group.LoadGroup.name
  count = 5
}



#this is example of count and count index in terraform
#this code will create 5 different load balancers with the help of count statement, it will run a loop 5 times
#to create 5 differnet load balancer and with help of count index we names eace load balancers different names 
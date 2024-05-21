provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "LoadGroup" {
  name     = "LoadBalancerRG"
  location = "Central india"
}

resource "azurerm_public_ip" "ipv4_ex" {
  name = "myIP${count.index}"
  resource_group_name = azurerm_resource_group.LoadGroup.name
  location = azurerm_resource_group.LoadGroup.location
  allocation_method = "Static"
  count = 3
  
}

resource "azurerm_lb" "MyLB" {
  name                = "LoadBalancer${count.index}"
  location            = azurerm_resource_group.LoadGroup.location
  resource_group_name = azurerm_resource_group.LoadGroup.name
  count = 3

  frontend_ip_configuration {
    name = "Public_ip"
    public_ip_address_id = azurerm_public_ip.ipv4_ex[count.index].id
  }

}


#this is example of count and count index in terraform
#this code will create 3 different load balancers and 3 different public ip's with the help of count statement, it will run a loop 5 times
#to create 5 differnet load balancer and with help of count index we names eace load balancers different names
#and alos it will associate each load balancer with frontend ip
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "My_lb" {
    name = "My_lb"
    location = "CentralIndia"
}

resource "azurerm_public_ip" "My_lb" {
    name = "my_ip"
    location = azurerm_resource_group.My_lb.location
    resource_group_name = azurerm_resource_group.My_lb.name
    allocation_method = "Static"
}

resource "azurerm_lb" "My_lb" {
    name = "LoadBalancer"
    location = azurerm_resource_group.My_lb.location
    resource_group_name = azurerm_resource_group.My_lb.name

    frontend_ip_configuration {
      name = "Public_ip"
      public_ip_address_id = azurerm_public_ip.My_lb.id
    }

}

#this code will create a loadbalancer as well as a resource group and a public ip
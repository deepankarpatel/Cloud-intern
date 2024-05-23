provider "azurerm" {
  features {   
  }
}

resource "azurerm_resource_group" "rg" {
    name = "myResources"
    location = "central india"
}


resource "azurerm_public_ip" "ip" {
  name = "public_ip"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Static"
}


resource "azurerm_network_security_group" "sg" {
  name                = "SecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


   security_rule {
    name                       = "Https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = var.app.port
    destination_port_range     = var.app_port
    source_address_prefix      = azurerm_public_ip.ip.ip_address
    destination_address_prefix = "*"
    
  }

}

#this code has predefine variables in "central location" file and it will fetch data from it

#also this will create a public ip and associate with network security group 

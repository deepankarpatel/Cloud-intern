provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource" {
  name = "beetal"
  location = "central india"
}

resource "azurerm_public_ip" "MyIP" {
  name = "ip-address"
  resource_group_name = azurerm_resource_group.resource.name
  location = azurerm_resource_group.resource.location
  allocation_method = "Static"

  provisioner "local-exec" {
    command = "echo ${self.ip_address} >> private_ips.txt"
  }
}


#this code will use use provisioner to save the ip_address in a local file name called private_ips.txt

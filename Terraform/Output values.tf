provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    name = "myRg"
    location = "Central India"
  
}

resource "azurerm_public_ip" "ip" {
  name = "internetProtocol"
  resource_group_name = "myrg"
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
}

output "public-ip" {
    value = azurerm_public_ip.ip.ip_address

}


#this code will create a resource group and a public ip and as a output it will fetch the ip from portal and show it to terminal
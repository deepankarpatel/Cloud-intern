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
    create_before_destroy = true
  }
}


#in this code when the changes happen terraform destroy and recreate the resource
#but with the help of create_before_destroy it will create the resource first and then destroy it
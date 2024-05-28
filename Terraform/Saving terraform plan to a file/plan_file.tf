provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Rg" {
  name = "file_save"
  location = "Central india"
}

resource "azurerm_lb" "yourLB" {
    name = "Your_Load"
    resource_group_name = azurerm_resource_group.Rg.name
    location = azurerm_resource_group.Rg.location
    count = 3
}


#in this code we saved the terraform plan to a file named "saveFile"
#to do this just enter command "terraform plan -out=filename" for example "terraform plan -out=saveFile"
#to run this save plan "terraform apply saveFile"
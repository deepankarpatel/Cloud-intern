provider "azurerm" {
  features {}
}

data "azurerm_virtual_machine" "vm1" {
  name = "vm1"
  resource_group_name = "vmGroup"
}

output "vm1" {
  value = data.azurerm_virtual_machine.vm1
}

#this code will fetch data from console of a virtual machine that created on console
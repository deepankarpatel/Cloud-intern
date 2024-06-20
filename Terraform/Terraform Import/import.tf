provider "azurerm" {
  features {}
}

import {
  to = azurerm_virtual_machine.myvm
  id = "/subscriptions/4111291e-e590-40cd-8bed-50da343c9fdd/resourceGroups/mesh/providers/Microsoft.Compute/virtualMachines/vmech"
  
}

#in this code we are importing manually created virtual machine in the terraform 
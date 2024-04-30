provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vmware" {
  name = "rg"
  location = "central india"
}

resource "azurerm_virtual_network" "vmware" {
    name = "vmware-network"
    address_space = [ "10.0.0.0/16" ]
    location = "central india"
    resource_group_name = "vmware"
}

resource "azurerm_subnet" "vmware" {
  name                 = "internal"
  resource_group_name  = "vmware"
  virtual_network_name = "vmware-network"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vmware" {
  name                = "vmware-nic"
  location            = "central india"
  resource_group_name = "vmware"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vmware.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "Runamatic" {
  name                = "Runamatic-vm"
  resource_group_name = "vmware"
  location            = "central india"
  size                = "Standard_F2"
  admin_username      = "Runamatic"
  admin_password      = "cloud@1234567"
  network_interface_ids = [
    azurerm_network_interface.vmware.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

#this is an terraform code using this code you can cerate virtual machine or virtual network 
# after creating this virtual machine you have assign public ip to vm and add rdp or http port rule in inbound rule
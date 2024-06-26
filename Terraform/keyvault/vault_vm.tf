provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "myrg" {
  name = "keyword"
}

data "azurerm_key_vault" "dev_key" {
  name = "secret-1234"
  resource_group_name = data.azurerm_resource_group.myrg.name
}

data "azurerm_key_vault_secret" "user_secret" {
name = "user-id" 
key_vault_id = data.azurerm_key_vault.dev_key.id
}
data "azurerm_key_vault_secret" "pass_secret" {
name = "password" 
key_vault_id = data.azurerm_key_vault.dev_key.id
}

resource "azurerm_public_ip" "myip" {

  name = "ip1"
  resource_group_name = data.azurerm_resource_group.myrg.name
  location = data.azurerm_resource_group.myrg.location
  allocation_method = "Static"
}

resource "azurerm_virtual_network" "vnet" {

  name                = "v_network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.myrg.location
  resource_group_name = data.azurerm_resource_group.myrg.name
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "interfae" {
  name                = "nic"
  location            = data.azurerm_resource_group.myrg.location
  resource_group_name = data.azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myip.id
  }
}

resource "azurerm_network_security_group" "nsg" {

  name                = "ns_group1"
  location            = data.azurerm_resource_group.myrg.location
  resource_group_name = data.azurerm_resource_group.myrg.name

  security_rule {
    name                       = "all_ports"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnet_1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_windows_virtual_machine" "v_machine" {
  name                = "veronika"
  resource_group_name = data.azurerm_resource_group.myrg.name
  location            = data.azurerm_resource_group.myrg.location
  size                = "Standard_DS1"
  admin_username      = data.azurerm_key_vault_secret.user_secret.value
  admin_password      = data.azurerm_key_vault_secret.pass_secret.value
  network_interface_ids = [
    azurerm_network_interface.interfae.id,
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


#this code is for a virtual machine calling username and password from keyvault
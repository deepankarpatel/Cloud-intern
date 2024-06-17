
resource "azurerm_resource_group" "myrg" {
  name = var.rg_name
  location = var.location
}

resource "azurerm_public_ip" "myip" {
  name = "ip1"
  resource_group_name = var.rg_name
  location = var.location
  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network" "vnet" {
  depends_on = [ azurerm_resource_group.myrg ]
  name                = "v_network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "internal"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "interfae" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myip.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  depends_on          = [ azurerm_resource_group.myrg ]
  name                = "ns_group1"
  location            = var.location
  resource_group_name = var.rg_name

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
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_DS1"
  admin_username      = var.username
  admin_password      = var.password
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

output "virtual_ip" {
 value = {
  
  public_ip_address = azurerm_public_ip.myip.ip_address
 }
}
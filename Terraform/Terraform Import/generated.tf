# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "azurerm_virtual_machine" "myvm" {
  availability_set_id              = null
  delete_data_disks_on_termination = null
  delete_os_disk_on_termination    = null
  license_type                     = null
  location                         = "centralindia"
  name                             = "vmech"
  network_interface_ids            = ["/subscriptions/4111291e-e590-40cd-8bed-50da343c9fdd/resourceGroups/mesh/providers/Microsoft.Network/networkInterfaces/vmech216_z1"]
  primary_network_interface_id     = null
  proximity_placement_group_id     = null
  resource_group_name              = "mesh"
  tags                             = {}
  vm_size                          = "Standard_B1s"
  zones                            = ["1"]
  additional_capabilities {
    ultra_ssd_enabled = false
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = ""
  }
  os_profile {
    computer_name = "vmech"
    admin_password = "cloud@1234567"
    admin_username = "cloud"
  } # sensitive
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = null
  }
  storage_image_reference {
    id        = null
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  storage_os_disk {
    caching                   = "ReadWrite"
    create_option             = "FromImage"
    disk_size_gb              = 127
    image_uri                 = null
    managed_disk_id           = "/subscriptions/4111291e-e590-40cd-8bed-50da343c9fdd/resourceGroups/mesh/providers/Microsoft.Compute/disks/vmech_disk1_ebb71a16477346c4b6963ddaf6c8c752"
    managed_disk_type         = "Premium_LRS"
    name                      = "vmech_disk1_ebb71a16477346c4b6963ddaf6c8c752"
    os_type                   = "Windows"
    vhd_uri                   = null
    write_accelerator_enabled = false
  }
}

#this is generted output by terraform generate-config-out command 
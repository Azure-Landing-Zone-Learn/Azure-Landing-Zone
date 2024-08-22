module "vm_vnet1" {
  source              = "./modules/virtual_machine"
  vm_name             = "vm-windows-2022"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  vm_size             = "Standard_B2s"

  network_interface_ids = [azurerm_network_interface.nic_vnet1.id]

  admin_username = "adminuser"
  admin_password = "P@ssw0rd1234!"  # Use a strong, secure password

  os_publisher = "MicrosoftWindowsServer"
  os_offer     = "WindowsServer"
  os_sku       = "2022-Datacenter"

}

module "vm_vnet2" {
  source              = "./modules/virtual_machine"
  vm_name             = "vm-ubuntu-2004"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  vm_size             = "Standard_B2s"

  network_interface_ids = [azurerm_network_interface.nic_vnet2.id]

  admin_username = "adminuser"
  admin_password = "P@ssw0rd1234!"  # Use a strong, secure password

  os_publisher = "Canonical"
  os_offer     = "UbuntuServer"
  os_sku       = "20.04-LTS"

}
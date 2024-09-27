resource "azurerm_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_size             = var.vm_size

  network_interface_ids = var.network_interface_ids

  storage_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 127 # Ensure vm is equal to or larger than the required disk size
    create_option     = "FromImage"
  }

  os_profile_linux_config {
    disable_password_authentication = var.os_profile_linux_config
  }

}

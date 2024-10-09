module "nics" {
  source = "../../modules/network_interface"

  for_each            = var.nics
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id
  tags                = var.tags
}

resource "azurerm_windows_virtual_machine" "window_vm" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  network_interface_ids = [for nic in module.nics : nic.id]

  os_disk {
    name                 = var.os_disk_name
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  size = var.size

  admin_username = var.admin_username
  admin_password = var.admin_password

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
}

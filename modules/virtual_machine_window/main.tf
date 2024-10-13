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

  computer_name = var.computer_name

  admin_username = var.admin_username
  admin_password = var.admin_password

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
}

output "private_ip_addresses" {
  value = flatten([for nic in module.nics : [for ip_config in nic.ip_configuration : ip_config.private_ip_address]])
}
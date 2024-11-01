module "nics" {
  source = "../../modules/network_interface"

  for_each            = var.nics
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration    = each.value.ip_configuration
  tags                = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
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

  size          = var.size
  computer_name = var.computer_name

  disable_password_authentication = var.disable_password_authentication
  admin_username                  = var.admin_username
  admin_password                  = var.disable_password_authentication ? null : var.admin_password

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.public_key
    }
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }

  tags = merge({
    Name = var.name
  }, var.tags)
}

output "private_ip_addresses" {
  value = flatten([for nic in module.nics : nic.private_ip_addresses])
}

output "network_interface_ids" {
  value = [for nic in module.nics : nic.id]
}
resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }

  tags = merge({
    Name = var.name
  }, var.tags)

}

output "id" {
  value = azurerm_network_interface.nic.id
}

output "private_ip_addresses" {
  value = flatten([for ip_config in azurerm_network_interface.nic.ip_configuration : ip_config.private_ip_address])
}

resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = contains(keys(var.public_ip_address_id), "public_ip_address_id") ? var.public_ip_address_id : null
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
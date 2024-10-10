resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                = var.sku
  virtual_network_id = var.sku == "Developer" ? var.virtual_network_id : null
}

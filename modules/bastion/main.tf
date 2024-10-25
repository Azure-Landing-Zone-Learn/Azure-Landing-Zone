module "pip" {
  source              = "../../modules/public_ip"
  count               = var.sku != "Developer" ? 1 : 0
  name                = var.public_ip_address_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_pip
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  virtual_network_id  = var.virtual_network_id

  dynamic "ip_configuration" {
    for_each = var.sku != "Developer" ? [1] : []
    content {
      name                 = var.ip_configuration_name
      public_ip_address_id = length(module.pip) > 0 ? module.pip[0].id : null
      subnet_id            = var.virtual_network_subnet_id
    }
  }
}

module "pip" {
  source = "../../modules/public_ip"

  name                = "pip-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_pip
  allocation_method   = var.allocation_method
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                = var.sku
  virtual_network_id = var.virtual_network_id

  dynamic "ip_configuration" {
    for_each = var.sku != "Developer" ? [1] : []
    content {
      name                 = "${var.name}-ip-config"
      public_ip_address_id = module.pip.id
      subnet_id            = var.virtual_network_subnet_id
    }
  }
}

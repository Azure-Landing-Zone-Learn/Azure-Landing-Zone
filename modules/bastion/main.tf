module "pip" {
  source              = "../../modules/public_ip"

  name                = var.public_ip_address_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_pip
  allocation_method   = "Static"

  count               = var.sku != "Developer" ? 1 : 0
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  virtual_network_id  = var.virtual_network_id

  ip_configuration {
    name                 = var.ip_configuration_name
    public_ip_address_id = module.pip[0].id
    subnet_id            = var.virtual_network_subnet_id
  }
}

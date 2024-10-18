resource "azurerm_container_registry" "acr" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled != null ? var.public_network_access_enabled : true
}

module "pe" {
  source              = "../../modules/private_endpoint"
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  
  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}

module "private_dns_zone" {
  source = "./.../modules/private_dns_zone"
  # privateLink.acrxxx.io
  name = "${var.private_dns_zone_name}.${var.name}.io"

  resource_group_name = var.resource_group_name
  # acr.acrxxx
  record_name = "acr.${var.name}"
  records     = [module.pe.private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "acr-dns-link-${var.name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.private_dns_zone.name
  virtual_network_id    = var.vnet_id
}

output "id" {
  value = azurerm_container_registry.acr.id
}
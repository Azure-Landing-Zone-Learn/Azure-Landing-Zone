resource "azurerm_container_registry" "acr" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.is_private ? false : true
}


module "pe" {
  source = "../../modules/private_endpoint"
  // TODO: pe_name not hardcode
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection = {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = [var.acr_subresource_name]
  }

  private_dns_zone_group = {
    name                 = "pdzg-${var.name}"
    private_dns_zone_ids = [module.private_dns_zone[0].id]  # Access the first item in the list
  }

  count = var.is_private ? 1 : 0
}


module "private_dns_zone" {
  source = "../../modules/private_dns_zone"
  name = var.private_dns_zone_name

  resource_group_name = var.resource_group_name
  record_name = "acr.${var.name}"
  records     = var.is_private ? [module.pe[0].private_ip_address] : []

  count = var.is_private ? 1 : 0
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  // TODO: name not hardcode
  name                  = "acr-dns-link-${var.name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.vnet_id

  depends_on = [module.private_dns_zone]

  count = var.is_private ? 1 : 0
}

output "id" {
  value = azurerm_container_registry.acr.id
}
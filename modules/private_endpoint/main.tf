resource "azurerm_private_endpoint" "pe" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id

  private_service_connection {
    name                           = var.private_service_connection.name
    private_connection_resource_id = var.private_service_connection.private_connection_resource_id
    is_manual_connection           = var.private_service_connection.is_manual_connection
    subresource_names              = var.private_service_connection.subresource_names
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group.name
    private_dns_zone_ids = var.private_dns_zone_group.private_dns_zone_ids
  }
}

output "private_ip_address" {
  value = azurerm_private_endpoint.pe.private_service_connection.0.private_ip_address
}
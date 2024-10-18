resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "a_record" {
  name                = var.record_name
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = var.records
}


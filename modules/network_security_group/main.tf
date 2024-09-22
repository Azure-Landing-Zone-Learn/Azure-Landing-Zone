resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                                       = security_rule.value.name
      description                                = contains(keys(security_rule.value), "description") ? security_rule.value.description : null
      protocol                                   = security_rule.value.protocol
      source_port_range                          = contains(keys(security_rule.value), "source_port_range") ? security_rule.value.source_port_range : null
      source_port_ranges                         = contains(keys(security_rule.value), "source_port_ranges") ? security_rule.value.source_port_ranges : null
      destination_port_range                     = contains(keys(security_rule.value), "destination_port_range") ? security_rule.value.destination_port_range : null
      destination_port_ranges                    = contains(keys(security_rule.value), "destination_port_ranges") ? security_rule.value.destination_port_ranges : null
      source_address_prefix                      = contains(keys(security_rule.value), "source_address_prefix") ? security_rule.value.source_address_prefix : null
      source_address_prefixes                    = contains(keys(security_rule.value), "source_address_prefixes") ? security_rule.value.source_address_prefixes : null
      source_application_security_group_ids      = contains(keys(security_rule.value), "source_application_security_group_ids") ? security_rule.value.source_application_security_group_ids : null
      destination_address_prefix                 = contains(keys(security_rule.value), "destination_address_prefix") ? security_rule.value.destination_address_prefix : null
      destination_application_security_group_ids = contains(keys(security_rule.value), "destination_application_security_group_ids") ? security_rule.destination_application_security_group_ids : null
      access                                     = security_rule.value.access
      priority                                   = security_rule.value.priority
      direction                                  = security_rule.value.direction
    }

  }

  tags = merge({
    Name = var.name
  }, var.tags)
}

output "id" {
  value = azurerm_network_security_group.nsg.id
}
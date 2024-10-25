resource "azurerm_firewall_nat_rule_collection" "fwnrc" {
  name                = var.name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action

  dynamic "rule" {
    for_each = var.rule

    content {
      name                  = rule.value.name
      description           = rule.value.description
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
    }
  }
}

// TODO: add to fw module
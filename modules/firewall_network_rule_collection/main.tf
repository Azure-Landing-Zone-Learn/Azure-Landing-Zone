resource "azurerm_firewall_network_rule_collection" "fwrc" {
  name                = var.name
  resource_group_name = var.resource_group_name
  azure_firewall_name = var.firewall_name
  action              = var.action
  priority            = var.priority

  dynamic "rule" {
    for_each = var.rule

    content {
      name                  = rule.value.name
      description           = rule.value.description
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

// TODO: add to fw module
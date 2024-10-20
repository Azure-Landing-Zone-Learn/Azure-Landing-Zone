resource "azurerm_firewall_network_rule_collection" "name" {
  name                = var.name
  resource_group_name = var.resource_group_name
  azure_firewall_name = var.firewall_name
  action              = var.action
  priority            = var.priority

  dynamic "rule" {
    for_each = var.rule

    content {
      name                  = rule.name
      description           = rule.description
      source_addresses      = rule.source_addresses
      source_ip_groups      = rule.source_ip_groups
      destination_addresses = rule.destination_addresses
      destination_ip_groups = rule.destination_ip_groups
      destination_fqdns     = rule.destination_fqdns
      destination_ports     = rule.destination_ports
      protocols             = rule.protocols
    }
  }
}
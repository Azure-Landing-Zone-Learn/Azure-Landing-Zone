# modules/virtual_network/main.tf

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  for_each                                      = var.subnets
  name                                          = each.value.name
  address_prefixes                              = each.value.address_prefixes
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  default_outbound_access_enabled               = contains(keys(each.value), "default_outbound_access_enabled") ? each.value.default_outbound_access_enabled : false
  private_endpoint_network_policies             = contains(keys(each.value), "private_endpoint_network_policies") ? each.value.private_endpoint_network_policies : "Disabled"
  private_link_service_network_policies_enabled = contains(keys(each.value), "private_link_service_network_policies_enabled") ? each.value.private_link_service_network_policies_enabled : true
  service_endpoints                             = contains(keys(each.value), "service_endpoints") ? each.value.service_endpoints : []
  service_endpoint_policy_ids                   = contains(keys(each.value), "service_endpoint_policy_ids") ? each.value.service_endpoint_policy_ids : []

  dynamic "delegation" {
    for_each = each.value.delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.name
        actions = delegation.value.actions
      }
    }
  }
}

output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}


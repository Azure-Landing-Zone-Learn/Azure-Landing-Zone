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
    for_each = contains(keys(each.value), "delegations") ? each.value.delegations : {}
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.name
        actions = delegation.value.actions
      }
    }
  }
}

resource "azurerm_subnet_route_table_association" "snet_rt_association" {
  for_each       = { for subnet in var.subnets : subnet.name => subnet if contains(keys(subnet), "route_table_id") }
  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = each.value.route_table_id
}

resource "azurerm_subnet_network_security_group_association" "nsg_snet_association" {
  for_each                  = { for subnet in var.subnets : subnet.name => subnet if contains(keys(subnet), "network_security_group_id") }
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = each.value.network_security_group_id
}

resource "azurerm_virtual_network_peering" "vnet_peerings" {
  for_each                               = var.peerings
  name                                   = each.value.name
  resource_group_name                    = each.value.resource_group_name
  virtual_network_name                   = azurerm_virtual_network.vnet.name
  remote_virtual_network_id              = each.value.remote_virtual_network_id
  allow_virtual_network_access           = contains(keys(each.value), "allow_virtual_network_access") ? each.value.allow_virtual_network_access : true
  allow_forwarded_traffic                = contains(keys(each.value), "allow_forwarded_traffic") ? each.value.allow_forwarded_traffic : false
  allow_gateway_transit                  = contains(keys(each.value), "allow_gateway_transit") ? each.value.allow_gateway_transit : false
  local_subnet_names                     = contains(keys(each.value), "local_subnet_names") ? each.value.local_subnet_names : []
  only_ipv6_peering_enabled              = contains(keys(each.value), "only_ipv6_peering_enabled") ? each.value.only_ipv6_peering_enabled : false
  peer_complete_virtual_networks_enabled = contains(keys(each.value), "peer_complete_virtual_networks_enabled") ? each.value.peer_complete_virtual_networks_enabled : true
  remote_subnet_names                    = contains(keys(each.value), "remote_subnet_names") ? each.value.remote_subnet_names : []
  use_remote_gateways                    = contains(keys(each.value), "use_remote_gateways") ? each.value.use_remote_gateways : false
  // triggers
}

output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  value = [for subnet in azurerm_subnet.subnet : subnet.id]
}

output "subnets" {
  value = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}
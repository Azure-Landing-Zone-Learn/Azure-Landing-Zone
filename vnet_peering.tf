resource "azurerm_virtual_network_peering" "peering_vnet1_to_vnet2" {
  name                = "vnet1-to-vnet2"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network_1.vnet_name
  remote_virtual_network_id = module.virtual_network_2.vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "peering_vnet2_to_vnet1" {
  name                = "vnet2-to-vnet1"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network_2.vnet_name
  remote_virtual_network_id = module.virtual_network_1.vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
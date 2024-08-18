module "virtual_network_1" {
  source              = "./modules/virtual_network"
  vnet_name           = "vnet-eastasia-001"
  address_space       = ["10.0.0.0/16"]
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  subnets = [
    {
      name            = "snet-eastasia-001"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name            = "snet-eastasia-002"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]
}

module "virtual_network_2" {
  source              = "./modules/virtual_network"
  vnet_name           = "vnet-eastasia-002"
  address_space       = ["10.1.0.0/16"]  # Different address space to avoid overlap
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  subnets = [
    {
      name            = "snet-eastasia-001"
      address_prefixes = ["10.1.1.0/24"]
    },
    {
      name            = "snet-eastasia-002"
      address_prefixes = ["10.1.2.0/24"]
    }
  ]
}

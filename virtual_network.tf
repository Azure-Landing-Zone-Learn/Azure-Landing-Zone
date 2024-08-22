module "virtual_network_1" {
  source              = "./modules/virtual_network"
  vnet_name           = "vnet-eastasia-001"
  address_space       = ["10.0.0.0/16"]
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  subnets = [
    {
      name             = "snet-eastasia-001"
      address_prefixes = ["10.0.1.0/24"]
    }
  ]
}

resource "azurerm_network_interface" "nic_vnet1" {
  name                = "nic-eastasia-001"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.virtual_network_1.subnet_ids[0]  # Reference the first subnet in vnet-eastasia-001
    private_ip_address_allocation = "Dynamic"
  }
}

module "virtual_network_2" {
  source              = "./modules/virtual_network"
  vnet_name           = "vnet-eastasia-002"
  address_space       = ["10.1.0.0/16"] # Different address space to avoid overlap
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  subnets = [
    {
      name             = "snet-eastasia-001"
      address_prefixes = ["10.1.1.0/24"]
    }
  ]
}

resource "azurerm_network_interface" "nic_vnet2" {
  name                = "nic-eastasia-002"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.virtual_network_2.subnet_ids[0]  # Reference the first subnet in vnet-eastasia-002
    private_ip_address_allocation = "Dynamic"
  }
}
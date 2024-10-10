locals {
  routes = [
    {
      name           = "route1"
      address_prefix = "10.0.0.0/24"
      next_hop_type  = "VirtualNetworkGateway"
    },
    {
      name                   = "route2"
      address_prefix         = "10.0.1.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "0.0.0.0"
    }
  ]

  subnets = [
    {
      name             = "subnet-${var.subscription_name}-${var.location}-001"
      address_prefixes = ["10.0.0.0/24"]
      route_table_id   = module.rt.id
    },
    {
      name                      = "subnet-${var.subscription_name}-${var.location}-002"
      address_prefixes          = ["10.0.1.0/24"]
      network_security_group_id = module.nsg.id
    },
    {
      name                      = "subnet-${var.subscription_name}-${var.location}-003"
      address_prefixes          = ["10.0.2.0/24"]
      network_security_group_id = module.nsg.id
    },
    {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.0.3.0/27"]
    }
  ]

  security_rules = [
    {
      name                       = "AllowMyIpAddressCustom8080Inbound"
      protocol                   = "*"
      access                     = "Allow"
      priority                   = 100
      direction                  = "Inbound"
      source_address_prefix      = "89.244.82.247"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "8080"
    }
  ]

  peerings = [
    {
      name                      = "vnet-peer-${var.subscription_name}-to-dms"
      resource_group_name       = module.rg.name
      remote_virtual_network_id = var.remote_virtual_network_id
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
    }
  ]
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_pip_name
  location            = var.location
  resource_group_name = module.rg.name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

resource "azurerm_bastion_host" "developer_bastion" {
  name                = "bastion-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name

  sku                = var.bastion_sku
  virtual_network_id = var.bastion_virtual_network_id

  ip_configuration {
    name                 = var.ip_configuration_name
    subnet_id            = module.vnet.subnets["AzureBastionSubnet"]
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

module "rg" {
  source = "../../modules/resource_group"

  name     = "rg-${var.subscription_name}-${var.location}-001"
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source = "../../modules/virtual_network"

  name                = "vnet-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  address_space       = var.address_space
  subnets             = { for subnet in local.subnets : subnet.name => subnet }
  peerings            = { for peering in local.peerings : peering.name => peering }
}

module "rt" {
  source = "../../modules/route_table"

  name                = "rt-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  routes              = { for route in local.routes : route.name => route }
  tags                = var.tags
}

module "nsg" {
  source = "../../modules/network_security_group"

  name           = "nsg-${var.subscription_name}-${var.location}-001"
  location       = var.location
  resource_group = module.rg.name
  tags           = var.tags
  security_rules = { for rule in local.security_rules : rule.name => rule }
}

output "vnet_id" {
  value = module.vnet.id
}
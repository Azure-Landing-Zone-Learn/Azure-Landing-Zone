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
      name                      = "subnet-${var.subscription_name}-${var.location}-001"
      address_prefixes          = ["10.0.0.0/24"]
      route_table_id            = module.rt.id
    },
    {
      name                      = "subnet-${var.subscription_name}-${var.location}-002"
      address_prefixes          = ["10.0.1.0/24"]
      route_table_id            = module.rt.id
      network_security_group_id = module.nsg.id

    },
    {
      name                      = "subnet-${var.subscription_name}-${var.location}-003"
      address_prefixes          = ["10.0.2.0/24"]
      route_table_id            = module.rt.id
      network_security_group_id = module.nsg.id

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

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

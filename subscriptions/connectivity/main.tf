locals {
  subnets = [
    {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.0.3.0/26"]
    },
    {
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.0.4.0/24"]
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

  firewall = {
    name                  = "fw-${var.subscription_name}-${var.location}-001"
    location              = var.location
    resource_group_name   = module.rg.name
    sku_name              = "AZFW_VNet"
    sku_tier              = "Standard"
    ip_configuration_name = "ipconfig"
    subnet_id             = module.vnet.subnets["AzureFirewallSubnet"]
    public_ip_address_id  = azurerm_public_ip.fw_pip.id
  }

  azurerm_firewall_network_rule_collection = {
    name                = "fw-nrc-${var.subscription_name}-${var.location}-001"
    resource_group_name = module.rg.name
    location            = var.location
    priority            = 100
    action              = "Allow"

    rules = [
      {
        name                  = "from-cicd-subnet-to-internet"
        description           = "Allow traffic from CICD subnet to the internet"
        source_addresses      = var.allowed_to_internet_vms_dms
        destination_addresses = ["*"]
        destination_ports     = ["*"]
      }
    ]
  }
}

resource "azurerm_public_ip" "fw_pip" {
  name                = var.fw_pip_name
  location            = var.location
  resource_group_name = module.rg.name
  allocation_method   = var.allocation_method
  sku                 = var.sku_pip
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

module "firewall" {
  source = "../../modules/firewall"

  name                = "fw-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration = {
    name                 = var.ip_configuration_name
    subnet_id            = module.vnet.subnets["AzureFirewallSubnet"]
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

module "firewall_network_rule_collection" {
  source = "../../modules/firewall_network_rule_collection"

  name                = local.azurerm_firewall_network_rule_collection.name
  resource_group_name = local.azurerm_firewall_network_rule_collection.resource_group_name
  firewall_name       = "fw-${var.subscription_name}-${var.location}-001"
  action              = local.azurerm_firewall_network_rule_collection.action
  priority            = local.azurerm_firewall_network_rule_collection.priority
  rule                = { for rule in local.azurerm_firewall_network_rule_collection.rules : rule.name => rule }
}


module "basic_bastion" {
  source = "../../modules/bastion"

  name                      = "bastion-${var.subscription_name}-${var.location}-001"
  location                  = var.location
  resource_group_name       = module.rg.name
  sku                       = "Basic"
  virtual_network_subnet_id = module.vnet.subnets["AzureBastionSubnet"]
}

output "vnet_id" {
  value = module.vnet.id
}
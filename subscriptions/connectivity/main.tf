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

  fw_network_rules = [
    {
      name                  = "from-dms-to-internet"
      description           = "Allow traffic from CICD subnet wihtin dms vnet to the internet"
      source_addresses      = var.allowed_to_internet_vms_dms
      destination_addresses = ["*"]
      destination_ports     = ["*"]
      protocols             = ["TCP"]
    }
  ]

  fw_dnat_rules = [
    {
      name                  = "ssh-to-dms-vms"
      description           = "Allow SSH traffic to DMS VMs"
      destination_addresses = [azurerm_public_ip.fw_pip.id]
      destination_ports     = ["22"]
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      translated_address    = var.allow_ssh_to_dms_vms[0]
      translated_port       = 22
    }
  ]
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

  name                = "fwnrc-${var.subscription_name}-${var.location}-001"
  resource_group_name = module.rg.name
  firewall_name       = "fw-${var.subscription_name}-${var.location}-001"
  action              = "Allow"
  priority            = 100
  rule                = local.fw_network_rules
}

module "azurerm_firewall_nat_rule_collection" {
  source = "../../modules/firewall_nat_rule_collection"

  name                = "fwnatrc-${var.subscription_name}-${var.location}-001"
  resource_group_name = module.rg.name
  firewall_name       = "fw-${var.subscription_name}-${var.location}-001"
  priority            = 100
  rule                = local.fw_dnat_rules
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

output "fw_private_ip_address" {
  value = module.firewall.private_ip_address
}
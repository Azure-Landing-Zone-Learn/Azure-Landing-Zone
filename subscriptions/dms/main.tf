locals {
  subnets = [
    {
      name             = "subnet-${var.subscription_name}-${var.location}-001"
      address_prefixes = ["10.1.0.0/24"]
    },
    {
      name             = "subnet-${var.subscription_name}-${var.location}-002"
      address_prefixes = ["10.1.1.0/24"]
    },
  ]
  virtual_machines = [
    {
      vm_name                 = "vm-${var.subscription_name}-${var.location}-001"
      vm_size                 = "STANDARD_DS1_V2"
      admin_username          = "tung"
      admin_password          = "Password123!"
      os_publisher            = "Canonical"
      os_offer                = "UbuntuServer"
      os_sku                  = "16.04-LTS"
      os_profile_linux_config = false
    },
    {
      vm_name                 = "vm-${var.subscription_name}-${var.location}-002"
      vm_size                 = "STANDARD_DS1_V2"
      admin_username          = "tung"
      admin_password          = "Password123!"
      os_publisher            = "Canonical"
      os_offer                = "UbuntuServer"
      os_sku                  = "16.04-LTS"
      os_profile_linux_config = false

    },
    {
      vm_name                 = "vm-${var.subscription_name}-${var.location}-003"
      vm_size                 = "STANDARD_DS1_V2"
      admin_username          = "tung"
      admin_password          = "Password123!"
      os_publisher            = "Canonical"
      os_offer                = "UbuntuServer"
      os_sku                  = "16.04-LTS"
      os_profile_linux_config = false

    }
  ]
  peerings = [
    {
      name                      = "vnet-peer-${var.subscription_name}-to-connectivity"
      resource_group_name       = module.rg.name
      remote_virtual_network_id = var.remote_virtual_network_id
      allow_forwarded_traffic   = true
    }
  ]

  network_interfaces = [
    {
      nic_name            = "nic-${var.subscription_name}-${var.location}-001"
      location            = var.location
      resource_group_name = module.rg.name
      subnet_id           = module.vnet.subnet_ids[0]
      tags                = var.tags
    },
    {
      nic_name            = "nic-${var.subscription_name}-${var.location}-002"
      location            = var.location
      resource_group_name = module.rg.name
      subnet_id           = module.vnet.subnet_ids[1]
      tags                = var.tags
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
  peerings            = { for peering in local.peerings : peering.name => peering }
}

/* module "network_interfaces_first_subnet" {
  source = "../../modules/network_interface"

  for_each = { for idx, vm in local.virtual_machines : idx => vm }

  name                = "nic-${var.subscription_name}-${var.location}-${each.key + 1}"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.vnet.subnet_ids[0]  
  tags                = var.tags
}

module "virtual_machines_first_subnet" {
  source = "../../modules/virtual_machine"

  for_each = { for idx, vm in local.virtual_machines : idx => vm }

  vm_name               = each.value.vm_name
  resource_group_name   = module.rg.name
  location              = var.location
  vm_size               = each.value.vm_size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  os_publisher          = each.value.os_publisher
  os_offer              = each.value.os_offer
  os_sku                = each.value.os_sku
  network_interface_ids = [module.network_interfaces_first_subnet[each.key].id]
} */

module "linux_vm" {
  source = "../../modules/virtual_machine_linux"

  nics                = { for idx, nic in local.network_interfaces : idx => nic }
  name                = ""
  location            = var.location
  resource_group_name = module.rg.name
  tags                = var.tags
  admin_username      = ""
}

output "nic_ids" {
  value = module.linux_vm.nic_ids
}

output "vnet_id" {
  value = module.vnet.id
}
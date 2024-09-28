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
    {
      name             = "subnet-${var.subscription_name}-${var.location}-003"
      address_prefixes = ["10.1.2.0/24"]
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
      name      = "nic-${var.subscription_name}-${var.location}-001"
      subnet_id = module.vnet.subnet_ids[0]
      tags      = var.tags
    },
    {
      name      = "nic-${var.subscription_name}-${var.location}-002"
      subnet_id = module.vnet.subnet_ids[1]
      tags      = var.tags
    },
    {
      name      = "nic-${var.subscription_name}-${var.location}-003"
      subnet_id = module.vnet.subnet_ids[2]
      tags      = var.tags
    }
  ]

  virtual_machines = [
    {
      vm_name        = "vm-${var.subscription_name}-${var.location}-001"
      vm_size        = "STANDARD_DS1_V2"
      admin_username = "tung"
      os_disk_name   = "os-disk-${var.subscription_name}-${var.location}-001"
      os_publisher   = "Canonical"
      os_offer       = "UbuntuServer"
      os_sku         = "16.04-LTS"
      computer_name  = "Tung macbook 1"
      disk_size_gb   = 30
      nics           = { "${local.network_interfaces[0].name}" = local.network_interfaces[0] }
    },
    {
      vm_name        = "vm-${var.subscription_name}-${var.location}-002"
      vm_size        = "STANDARD_DS1_V2"
      admin_username = "tung"
      os_disk_name   = "os-disk-${var.subscription_name}-${var.location}-002"
      os_publisher   = "Canonical"
      os_offer       = "UbuntuServer"
      os_sku         = "16.04-LTS"
      computer_name  = "Tung macbook 2"
      disk_size_gb   = 30
      nics           = { "${local.network_interfaces[1].name}" = local.network_interfaces[1] }
    },
    {
      vm_name        = "vm-${var.subscription_name}-${var.location}-003"
      vm_size        = "STANDARD_DS1_V2"
      admin_username = "tung"
      os_disk_name   = "os-disk-${var.subscription_name}-${var.location}-003"
      os_publisher   = "Canonical"
      os_offer       = "UbuntuServer"
      os_sku         = "16.04-LTS"
      computer_name  = "Tung macbook 3"
      disk_size_gb   = 30
      nics           = { "${local.network_interfaces[2].name}" = local.network_interfaces[2] }
    }
  ]
}


resource "random_password" "linux_server_password" {
  for_each    = { for vm in local.virtual_machines : vm.vm_name => vm }
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = false
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

module "linux_vms" {
  source = "../../modules/virtual_machine_linux"

  for_each = { for vm in local.virtual_machines : vm.vm_name => vm }

  name                = each.value.vm_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = var.tags
  size                = each.value.vm_size
  computer_name       = each.value.computer_name
  admin_username      = each.value.admin_username
  admin_password      = random_password.linux_server_password[each.key].result
  os_disk_name        = each.value.os_disk_name
  publisher           = each.value.os_publisher
  offer               = each.value.os_offer
  sku                 = each.value.os_sku
  nics                = each.value.nics
  disk_size_gb        = each.value.disk_size_gb
}

output "vnet_id" {
  value = module.vnet.id
}
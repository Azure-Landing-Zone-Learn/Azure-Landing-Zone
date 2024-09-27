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
      vm_name               = "vm-${var.subscription_name}-${var.location}-001"
      resource_group_name   = module.rg.name
      location              = var.location
      vm_size               = "STANDARD_DS1_V2"
      admin_username        = "tung"
      admin_password        = "tunghaha2754!-"
      os_publisher          = "Canonical"
      os_offer              = "UbuntuServer"
      os_sku                = "16.04-LTS"
      network_interface_ids = [module.nic.id]
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

module "nic" {
  source = "../../modules/network_interface"

  name                = "nic-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.vnet.subnet_ids[0]
  tags                = var.tags
}

module "vm_1" {
  source = "../../modules/virtual_machine"

  vm_name               = "vm-${var.subscription_name}-${var.location}-001"
  resource_group_name   = module.rg.name
  location              = var.location
  vm_size               = local.virtual_machines[0].vm_size
  admin_username        = local.virtual_machines[0].admin_username
  admin_password        = local.virtual_machines[0].admin_password
  os_publisher          = local.virtual_machines[0].os_publisher
  os_offer              = local.virtual_machines[0].os_offer
  os_sku                = local.virtual_machines[0].os_sku
  network_interface_ids = [module.nic.id]
}
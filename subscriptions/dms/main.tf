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
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_connectivity_id
  alias           = "connectivity"
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_dms_id
  alias           = "dms"
}

locals {
  tags = {
    terraform   = true
    environment = "Terraform Demo"
  }

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
}

module "connectivity_subscription" {
  source = "./subscriptions/connectivity"

  location          = var.location
  subscription_name = var.subscription_connectivity_name
  tags              = local.tags

  providers = {
    azurerm = azurerm.connectivity
  }
}

module "dms_subscription" {
  source = "./subscriptions/dms"

  location          = var.location
  subscription_name = var.subscription_dms_name
  tags              = local.tags

  providers = {
    azurerm = azurerm.dms
  }
}

output "subnet_ids" {
  value = module.connectivity_subscription.subnet_ids
}

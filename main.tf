terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

module "resource_group" {
  source = "./modules/resource_group"  # Adjust the path to your resource_group module if necessary

  resource_group_name = "rg-eastasia-001"
  location            = var.location  # Use the default or specify another location
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  vnet_name           = "vnet-eastasia-001"
  address_space       = ["10.0.0.0/16"]
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name

  subnets = [
    {
      name            = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name            = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]
}
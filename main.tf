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

  subscription_id = var.subscription_id
}

locals {
  tags = {
    terraform   = true
    environment = "Terraform Demo"
  }

    subnets = [
    {
      name             = "subnet-abc-001"
      address_prefixes = ["10.0.0.0/24"]
    },
    {
      name             = "subnet-abc-${var.location}-002"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "subnet-abc-${var.location}-003"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]

  list_test = [
    "abc",
    "test"
  ]
}

output "test" {
  value = [for s in local.local.list_test : upper(s)]
}

/* module "connectivity_subscription" {
  source = "./subscriptions/connectivity"

  location          = var.location
  subscription_name = var.subscription_connectivity_name
  tags              = local.tags
} */


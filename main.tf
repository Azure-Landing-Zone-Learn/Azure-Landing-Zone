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
}

module "connectivity_subscription" {
  source = "./subscriptions/connectivity"

  location          = var.location
  subscription_name = var.subscription_connectivity_name
  tags              = local.tags
}
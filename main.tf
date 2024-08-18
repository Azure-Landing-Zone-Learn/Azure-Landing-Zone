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
  source = "./moudles/resource_group"  # Adjust the path to your resource_group module if necessary

  resource_group_name = "rg-eastasia-001"
  location            = var.location  # Use the default or specify another location
}
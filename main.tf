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

  subscription_id = "f3201a06-2f4e-4b3b-9a7a-7a54898ea3d2"
  client_id       = "b67cb59f-b8b0-4a5e-8b04-76d0f67d3b08"
  client_secret   = "4A38Q~nAH~ZWoZFI7LwjpSUzgfmjqjnSYkF_Hbp9"
  tenant_id       = "4878e7ff-70ef-4ed9-8e6e-f13f1073f0ea"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "somestgacc1234"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

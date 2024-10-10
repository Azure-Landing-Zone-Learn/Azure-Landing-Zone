# Define allowed locations for Developer SKU
locals {
  developer_allowed_locations = [
    "Central US EUAP",
    "East US 2 EUAP",
    "West Central US",
    "North Central US",
    "West US",
    "North Europe"
  ]

  # Check if the location is allowed for Developer SKU
  is_valid_developer_location = var.sku == "Developer" ? contains(local.developer_allowed_locations, var.location) : true
}

# Raise an error if the location is invalid for Developer SKU
resource "null_resource" "check_developer_sku_location" {
  count = var.sku == "Developer" && !local.is_valid_developer_location ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'Error: Invalid location for Developer SKU'"
  }
}

# Bastion Host Resource
resource "azurerm_bastion_host" "developer_bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                = var.sku
  virtual_network_id = var.sku == "Developer" ? var.virtual_network_id : null

  # This resource will only be created if SKU is Developer and location is valid
  depends_on = [null_resource.check_developer_sku_location]
}

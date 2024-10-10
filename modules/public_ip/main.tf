resource "azurerm_public_ip" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

output "id" {
  value = azurerm_public_ip.pip.id
}

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags = merge({
    Name = var.name
  }, var.tags)
}

output "id" {
  value = azurerm_resource_group.rg.id
}

output "name" {
  value = azurerm_resource_group.rg.name
}

# private acr

module "pe" {
  source              = "../../modules/private_endpoint"
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id

    private_service_connection = {
        name                           = var.private_service_connection.name
        private_connection_resource_id = var.private_service_connection.private_connection_resource_id
        is_manual_connection           = var.private_service_connection.is_manual_connection
    }
}

resource "azurerm_container_registry" "acr" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
}
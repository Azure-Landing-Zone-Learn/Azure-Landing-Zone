resource "azurerm_mssql_server" "server" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  public_network_access_enabled = var.public_network_access_enabled

  connection_policy = var.connection_policy

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []
    content {
      login_username              = azuread_administrator.value.login_username
      tenant_id                   = azuread_administrator.value.tenant_id
      object_id                   = azuread_administrator.value.object_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }
  }
}

module "pe" {
  source              = "../../modules/private_endpoint"
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id

  private_service_connection = {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_mssql_server.server.id
    is_manual_connection           = false
    subresource_names              = [var.sql_subresource_name]
  }

  private_dns_zone_group = {
    name                 = "pdzg-${var.name}"
    private_dns_zone_ids = [module.private_dns_zone.id]
  }

  count = var.is_private ? 1 : 0
}


module "private_dns_zone" {
  source = "../../modules/private_dns_zone"
  # privateLink.mssqlxxx.io
  name = var.private_dns_zone_name

  resource_group_name = var.resource_group_name
  # mssql.mssqlxxx
  // TODO: record_name not hardcode
  record_name = "mssql.${var.name}"
  records     = var.is_private ? [module.pe[0].private_ip_address] : []

  count = var.is_private ? 1 : 0

}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  // TODO: name not hardcode
  name                  = "mssql-dns-link-${var.name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.vnet_id

  depends_on = [module.private_dns_zone]

  count = var.is_private ? 1 : 0
}

resource "azurerm_mssql_virtual_network_rule" "virtual_network_rules" {
  count = var.is_private ? 0 : length(var.virtual_network_rules)

  name                                 = var.virtual_network_rules[count.index].name
  server_id                            = azurerm_mssql_server.server.id
  subnet_id                            = var.virtual_network_rules[count.index].subnet_id
  ignore_missing_vnet_service_endpoint = true
}

output "id" {
  value = azurerm_mssql_server.server.id
}
resource "azurerm_mssql_server" "server" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

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

output "id" {
  value = azurerm_mssql_server.server.id
}
resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  connection_policy = var.connection_policy

  identity {
    type         = var.server_identity.identity_type
    identity_ids = var.server_identity.identity_ids
  }

  azuread_administrator {
    login_username              = var.azuread_administrator.login_username
    tenant_id                   = var.azuread_administrator.tenant_id
    object_id                   = var.azuread_administrator.object_id
    azuread_authentication_only = var.azuread_administrator.azuread_authentication_only
  }
}

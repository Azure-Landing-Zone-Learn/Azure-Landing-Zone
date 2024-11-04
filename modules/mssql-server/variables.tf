#server
variable "name" {
  description = "The name of the SQL Server"
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of the resource group in which the SQL Server will be created"
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location/region where the SQL Server will be created"
  type        = string
  nullable    = false
}

variable "version" {
  description = "The version of the SQL Server"
  type        = string
  default     = "12.0"
  nullable    = false
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server"
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server"
  type        = string
}

variable "azuread_administrator" {
  description = "The Azure AD administrator for the SQL Server"
  type = object({
    login_username              = string
    tenant_id                   = string
    object_id                   = string
    azuread_authentication_only = bool
  })
}

variable "connection_policy" {
  description = "The connection policy for the SQL Server"
  type        = string
  default     = "Default"
}

variable "identity" {
  description = "The identity for the SQL Server"
  type = object({
    identity_type = string
    identity_ids  = list(string)
  })
}

variable "database_identity" {
  description = "The identity for the SQL Server"
  type = object({
    identity_type = string
    identity_ids  = list(string)
  })
}

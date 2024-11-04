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

variable "sql_server_version" {
  description = "The version of the SQL Server"
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server"
  type        = string
  default     = null
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server"
  type        = string
  default     = null
}

variable "azuread_administrator" {
  description = "The Azure AD administrator for the SQL Server"
  type = object({
    login_username              = string
    tenant_id                   = string
    object_id                   = string
    azuread_authentication_only = bool
  })
  default = null
}

variable "connection_policy" {
  description = "The connection policy for the SQL Server"
  type        = string
  default     = "Default"
}

variable "identity" {
  description = "The identity for the SQL Server"
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

# PE
variable "is_private" {
  description = "Is the SQL Server private"
  type        = bool
}

variable "subnet_id" {
  description = "The id of the subnet"
  type        = string
  default     = null
}

variable "sql_subresource_name" {
  description = "The subresource name of the SQL Server"
  type        = string
  default     = "sqlServer"
}

variable "private_dns_zone_name" {
  description = "The name of the private dns zone"
  type        = string
  default     = "privateLink.database.windows.net"
}

variable "vnet_id" {
  description = "The id of the virtual network"
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the SQL Server"
  type        = bool
  default     = true
}

# rule
variable "virtual_network_rules" {
  description = "List of virtual network rules for the SQL server, each containing a name and subnet ID."
  type = list(object({
    name      = string
    subnet_id = string
  }))
  default = []
}

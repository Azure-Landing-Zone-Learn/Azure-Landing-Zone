
# Database
variable "database_name" {
  description = "The name of the SQL Database"
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of the resource group in which the SQL Database will be created"
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location/region where the SQL Database will be created"
  type        = string
  nullable    = false
}

variable "auto_pause_delay_in_minutes" {
  description = "The number of minutes after which the database is paused"
  type        = number
}

variable "create_mode" {
  description = "The create mode for the SQL Database"
  type        = string
  default     = "Default"
}

variable "import" {
  description = "The import configuration for the SQL Database"
  type = object({
    storage_uri                  = string
    storage_key                  = string
    storage_key_type             = string
    administrator_login          = string
    administrator_login_password = string
    authentication_type          = string
    storage_account_id           = optional(string)
  })
}

variable "create_source_database_id" {
  description = "The ID of the source database to create the SQL Database from"
  type        = string
}

variable "collation" {
  description = "The collation for the SQL Database"
  type        = string
}

variable "elastic_pool_id" {
  description = "The ID of the elastic pool to associate the SQL Database with"
  type        = string
}

variable "enclave_type" {
  description = "The enclave type for the SQL Database"
  type        = string
}

variable "geo_backup_enabled" {
  description = "Is geo backup enabled for the SQL Database"
  type        = bool
}

variable "maintenance_configuration_name" {
  description = "The name of the maintenance configuration for the SQL Database"
  type        = string
}

variable "ledger_enabled" {
  description = "Is ledger enabled for the SQL Database"
  type        = bool
}

variable "license_type" {
  description = "The license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  type        = string
}

variable "long_term_retention_policy" {
  description = "The long-term retention policy for the SQL Database backups"
  type = object({
    weekly_retention  = string
    monthly_retention = string
    yearly_retention  = string
    week_of_year      = number
  })
}

variable "max_size_gb" {
  description = "The maximum size of the SQL Database in gigabytes"
  type        = number
}

variable "min_capacity" {
  description = "The minimal capacity that database will always have allocated, if not paused. Only settable for Serverless databases."
  type        = number
}

variable "restore_point_in_time" {
  description = "The point in time to restore the SQL Database to (ISO8601 format). Only settable for create_mode = PointInTimeRestore."
  type        = string
}

variable "recover_database_id" {
  description = "The ID of the database to recover. Applicable when create_mode is Recovery."
  type        = string
}

variable "recovery_point_id" {
  description = "The ID of the Recovery Services Recovery Point Id to be restored. Applicable when create_mode is Recovery."
  type        = string
}

variable "restore_dropped_database_id" {
  description = "The ID of the database to restore. Applicable when create_mode is Restore."
  type        = string
}

variable "restore_long_term_retention_backup_id" {
  description = "The ID of the long-term retention backup to restore. Applicable when create_mode is RestoreLongTermRetentionBackup."
  type        = string
}

variable "read_replica_count" {
  description = "The number of readonly secondary replicas associated with the database"
  type        = number
}

variable "read_scale" {
  description = "Enables read scale. Only settable for Premium and Business Critical databases"
  type        = bool
}

variable "sample_name" {
  description = "Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
  type        = string
}

variable "short_term_retention_policy" {
  description = "Short-term retention policy configuration for the SQL Database backups"
  type = object({
    retention_days = number
  })
}

variable "sku_name" {
  description = "Specifies the SKU used by the database. Examples: GP_S_Gen5_2, HS_Gen4_1, BC_Gen5_2, ElasticPool, Basic, S0, P2, DW100c, DS100."
  type        = string
}

variable "storage_account_type" {
  description = "Specifies the storage account type used to store backups for this database. Possible values are Geo, GeoZone, Local, and Zone."
  type        = string
}

variable "threat_detection_policy" {
  description = "Threat detection policy configuration"
  type = object({
    state                = string
    email_addresses      = list(string)
    email_account_admins = bool
    disabled_alerts      = list(string)
    retention_days       = number
  })
}

variable "transparent_data_encryption_enabled" {
  description = "Enables Transparent Data Encryption on the database. Defaults to true."
  type        = bool
  default     = true
}

variable "transparent_data_encryption_key_vault_key_id" {
  description = "The Key Vault Key URL to be used as the Customer Managed Key for Transparent Data Encryption (TDE)."
  type        = string
}

variable "transparent_data_encryption_key_automatic_rotation_enabled" {
  description = "Specifies whether TDE automatically rotates the encryption Key to the latest version."
  type        = bool
  default     = false
}

variable "zone_redundant" {
  description = "Indicates if the database is zone redundant (spreads replicas across availability zones). Only settable for Premium and Business Critical databases."
  type        = bool
}

variable "secondary_type" {
  description = "Defines how the replica is made. Valid values are Geo and Named. Defaults to Geo."
  type        = string
  default     = "Geo"
}

variable "creation_source_database_id" {
  description = "The ID of the source database to create the SQL Database from"
  type        = string
}

# PE
variable "is_private" {
  description = "Is the SQL Server private"
  type        = bool
  nullable    = false
}

variable "subnet_id" {
  description = "The ID of the subnet to place the SQL Server in"
  type        = string
}

variable "sql_subresource_name" {
  description = "The subresource name of the SQL Server"
  type        = string
  default     = "databases"
}

variable "private_dns_zone_name" {
  description = "The name of the private dns zone"
  type        = string
  default     = "privateLink.database.windows.net"
}

variable "vnet_id" {
  description = "The id of the virtual network"
  type        = string
  nullable    = false
}
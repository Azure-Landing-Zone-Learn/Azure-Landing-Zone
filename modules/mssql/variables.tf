
# Database
variable "name" {
  description = "The name of the SQL Database"
  type        = string
  nullable    = false
}

variable "server_id" {
  description = "The ID of the SQL Server to create the SQL Database on"
  type        = string
  nullable    = false
}

variable "auto_pause_delay_in_minutes" {
  description = "The number of minutes after which the database is paused"
  type        = number
  default     = null
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
  default = null
}

variable "create_source_database_id" {
  description = "The ID of the source database to create the SQL Database from"
  type        = string
  default     = null
}

variable "collation" {
  description = "The collation for the SQL Database"
  type        = string
  default     = null
}

variable "elastic_pool_id" {
  description = "The ID of the elastic pool to associate the SQL Database with"
  type        = string
  default     = null
}

variable "enclave_type" {
  description = "The enclave type for the SQL Database"
  type        = string
  default     = null
}

variable "geo_backup_enabled" {
  description = "Is geo backup enabled for the SQL Database"
  type        = bool
  default     = null
}

variable "maintenance_configuration_name" {
  description = "The name of the maintenance configuration for the SQL Database"
  type        = string
  default     = null
}

variable "ledger_enabled" {
  description = "Is ledger enabled for the SQL Database"
  type        = bool
  default     = null
}

variable "license_type" {
  description = "The license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  type        = string
  default     = null
}

variable "long_term_retention_policy" {
  description = "The long-term retention policy for the SQL Database backups"
  type = object({
    weekly_retention  = string
    monthly_retention = string
    yearly_retention  = string
    week_of_year      = number
  })
  default = null
}

variable "max_size_gb" {
  description = "The maximum size of the SQL Database in gigabytes"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "The minimal capacity that database will always have allocated, if not paused. Only settable for Serverless databases."
  type        = number
  default     = null
}

variable "restore_point_in_time" {
  description = "The point in time to restore the SQL Database to (ISO8601 format). Only settable for create_mode = PointInTimeRestore."
  type        = string
  default     = null
}

variable "recover_database_id" {
  description = "The ID of the database to recover. Applicable when create_mode is Recovery."
  type        = string
  default     = null
}

variable "recovery_point_id" {
  description = "The ID of the Recovery Services Recovery Point Id to be restored. Applicable when create_mode is Recovery."
  type        = string
  default     = null
}

variable "restore_dropped_database_id" {
  description = "The ID of the database to restore. Applicable when create_mode is Restore."
  type        = string
  default     = null
}

variable "restore_long_term_retention_backup_id" {
  description = "The ID of the long-term retention backup to restore. Applicable when create_mode is RestoreLongTermRetentionBackup."
  type        = string
  default     = null
}

variable "read_replica_count" {
  description = "The number of readonly secondary replicas associated with the database"
  type        = number
  default     = null
}

variable "read_scale" {
  description = "Enables read scale. Only settable for Premium and Business Critical databases"
  type        = bool
  default     = null
}

variable "sample_name" {
  description = "Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
  type        = string
  default     = null
}

variable "short_term_retention_policy" {
  description = "Short-term retention policy configuration for the SQL Database backups"
  type = object({
    retention_days = number
  })
  default = null
}

variable "sku_name" {
  description = "Specifies the SKU used by the database. Examples: GP_S_Gen5_2, HS_Gen4_1, BC_Gen5_2, ElasticPool, Basic, S0, P2, DW100c, DS100."
  type        = string
  default     = null
}

variable "storage_account_type" {
  description = "Specifies the storage account type used to store backups for this database. Possible values are Geo, GeoZone, Local, and Zone."
  type        = string
  default     = null
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
  default = null
}

variable "transparent_data_encryption_enabled" {
  description = "Enables Transparent Data Encryption on the database. Defaults to true."
  type        = bool
  default     = true
}

variable "transparent_data_encryption_key_vault_key_id" {
  description = "The Key Vault Key URL to be used as the Customer Managed Key for Transparent Data Encryption (TDE)."
  type        = string
  default     = null
}

variable "transparent_data_encryption_key_automatic_rotation_enabled" {
  description = "Specifies whether TDE automatically rotates the encryption Key to the latest version."
  type        = bool
  default     = null
}

variable "zone_redundant" {
  description = "Indicates if the database is zone redundant (spreads replicas across availability zones). Only settable for Premium and Business Critical databases."
  type        = bool
  default     = null
}

variable "secondary_type" {
  description = "Defines how the replica is made. Valid values are Geo and Named. Defaults to Geo."
  type        = string
  default     = "Geo"
}

variable "creation_source_database_id" {
  description = "The ID of the source database to create the SQL Database from"
  type        = string
  default     = null
}


variable "identity" {
  description = "The identity for the SQL Server"
  type = object({
    identity_type = string
    identity_ids  = list(string)
  })
  default = null
}


resource "azurerm_mssql_database" "database" {
  name      = var.name
  server_id = var.server_id

  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  create_mode                 = var.create_mode

  dynamic "import" {
    for_each = var.import != null ? [var.import] : []
    content {
      storage_uri                  = import.value.storage_uri
      storage_key                  = import.value.storage_key
      storage_key_type             = import.value.storage_key_type
      administrator_login          = import.value.administrator_login
      administrator_login_password = import.value.administrator_login_password
      authentication_type          = import.value.authentication_type
      storage_account_id           = import.value.storage_account_id
    }
  }

  # Database settings
  creation_source_database_id = var.creation_source_database_id
  collation                   = var.collation
  elastic_pool_id             = var.elastic_pool_id
  enclave_type                = var.enclave_type
  geo_backup_enabled          = var.geo_backup_enabled
  ledger_enabled              = var.ledger_enabled
  license_type                = var.license_type

  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? [var.long_term_retention_policy] : []
    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }

  max_size_gb                           = var.max_size_gb
  min_capacity                          = var.min_capacity
  restore_point_in_time                 = var.restore_point_in_time
  recover_database_id                   = var.recover_database_id
  recovery_point_id                     = var.recovery_point_id
  restore_dropped_database_id           = var.restore_dropped_database_id
  restore_long_term_retention_backup_id = var.restore_long_term_retention_backup_id
  read_replica_count                    = var.read_replica_count
  read_scale                            = var.read_scale
  sample_name                           = var.sample_name

  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy != null ? [var.short_term_retention_policy] : []
    content {
      retention_days = short_term_retention_policy.value.retention_days
    }
  }
  sku_name             = var.sku_name
  storage_account_type = var.storage_account_type
  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy != null ? [var.threat_detection_policy] : []
    content {
      state                = threat_detection_policy.value.state
      email_addresses      = threat_detection_policy.value.email_addresses
      email_account_admins = threat_detection_policy.value.email_account_admins
      disabled_alerts      = threat_detection_policy.value.disabled_alerts
      retention_days       = threat_detection_policy.value.retention_days
    }
  }
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  transparent_data_encryption_enabled                        = var.transparent_data_encryption_enabled
  transparent_data_encryption_key_vault_key_id               = var.transparent_data_encryption_key_vault_key_id
  transparent_data_encryption_key_automatic_rotation_enabled = var.transparent_data_encryption_key_automatic_rotation_enabled
  zone_redundant                                             = var.zone_redundant
  secondary_type                                             = var.secondary_type

}

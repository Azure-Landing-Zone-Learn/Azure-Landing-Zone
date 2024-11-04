
resource "azurerm_mssql_database" "database" {
  name                        = var.name
  server_id                   = azurerm_mssql_server.server.id
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  create_mode                 = var.create_mode

  import {
    storage_uri                  = var.import.storage_uri
    storage_key                  = var.import.storage_key
    storage_key_type             = var.import.storage_key_type
    administrator_login          = var.import.administrator_login
    administrator_login_password = var.import.administrator_login_password
    authentication_type          = var.import.authentication_type
    storage_account_id           = var.import.storage_account_id
  }

  # Database settings
  creation_source_database_id = var.creation_source_database_id
  collation                   = var.collation
  elastic_pool_id             = var.elastic_pool_id
  enclave_type                = var.enclave_type
  geo_backup_enabled          = var.geo_backup_enabled
  ledger_enabled              = var.ledger_enabled
  license_type                = var.license_type

  long_term_retention_policy {
    weekly_retention  = var.long_term_retention_policy.weekly_retention
    monthly_retention = var.long_term_retention_policy.monthly_retention
    yearly_retention  = var.long_term_retention_policy.yearly_retention
    week_of_year      = var.long_term_retention_policy.week_of_year
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
  short_term_retention_policy {
    retention_days = var.short_term_retention_policy.retention_days
  }
  sku_name             = var.sku_name
  storage_account_type = var.storage_account_type
  threat_detection_policy {
    state                = var.threat_detection_policy.state
    email_addresses      = var.threat_detection_policy.email_addresses
    email_account_admins = var.threat_detection_policy.email_account_admins
    disabled_alerts      = var.threat_detection_policy.disabled_alerts
    retention_days       = var.threat_detection_policy.retention_days
  }
  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
  transparent_data_encryption_enabled                        = var.transparent_data_encryption_enabled
  transparent_data_encryption_key_vault_key_id               = var.transparent_data_encryption_key_vault_key_id
  transparent_data_encryption_key_automatic_rotation_enabled = var.transparent_data_encryption_key_automatic_rotation_enabled
  zone_redundant                                             = var.zone_redundant
  secondary_type                                             = var.secondary_type

}

module "pe" {
  source              = "../../modules/private_endpoint"
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection = {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_mssql_database.database.id
    is_manual_connection           = false
    subresource_names              = [var.sql_subresource_name]
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

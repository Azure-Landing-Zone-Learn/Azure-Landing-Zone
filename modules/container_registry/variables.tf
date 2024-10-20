variable "name" {
  description = "The name of the acr"
  type        = string
}

variable "location" {
  description = "The location/region where the acr will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the acr will be created"
  type        = string
}

variable "sku" {
  description = "The SKU of the acr"
  type        = string
}

variable "admin_enabled" {
  description = "Is admin enabled for the acr"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the acr"
  type        = bool
  default     = true
}

variable "private_dns_zone_name" {
  description = "The name of the private dns zone"
  type        = string
  nullable    = false
}

variable "vnet_id" {
  description = "The id of the virtual network"
  type        = string
  nullable    = false
}

variable "subnet_id" {
  description = "The id of the subnet"
  type        = string
  nullable    = false
}

variable "private_dns_zone_name" {
  description = "The name of the private dns zone"
  type        = string
  default     = "privateLink.azurecr.io"
}

variable "acr_subresource_name" {
  description = "The subresource name of the acr"
  type        = string
  default     = "registry"
}
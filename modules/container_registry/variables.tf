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

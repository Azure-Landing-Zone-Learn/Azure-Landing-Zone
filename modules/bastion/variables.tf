variable "name" {
  description = "name of bastion host"
  type        = string
  nullable    = false
}

variable "location" {
  description = "location of bastion host"
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "resource group name of bastion host"
  type        = string
  nullable    = false
}

variable "sku" {
  description = "sku of bastion host"
  type        = string
  nullable    = false
}

variable "virtual_network_id" {
  description = "virtual network id of bastion host"
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "subnet id of bastion host"
  type        = string
  default     = null
}

variable "sku_pip" {
  description = "The SKU of pip"
  type        = string
  default     = "Standard"
}

variable "ip_configuration_name" {
  description = "The name of the ip configuration"
  type        = string
  default     = "ipconfig"
}

variable "public_ip_address_name" {
  description = "The name of the public IP address"
  type        = string
  nullable    = true
}
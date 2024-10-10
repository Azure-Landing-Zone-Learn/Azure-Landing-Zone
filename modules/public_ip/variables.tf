variable "name" {
  description = "value of the name"
  nullable    = false
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the pip will be created"
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location where the pip will be created"
  type        = string
  nullable    = false
}

variable "sku" {
  description = "The SKU tier for the pip"
  type        = string
  default     = "Standard"
}

variable "allocation_method" {
  description = "The allocation method for the public IP address"
  type        = string
  default     = "Static"
}
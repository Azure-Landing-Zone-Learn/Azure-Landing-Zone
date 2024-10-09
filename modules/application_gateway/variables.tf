variable "name" {
  description = "value of the name"
  nullable    = false
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the application gateway will be created"
  type        = string
}

variable "location" {
  description = "The location where the application gateway will be created"
  type        = string
}

variable "sku_name" {
  description = "The name of the SKU used for this application gateway"
  type        = string
}

variable "sku_tier" {
  description = "The tier of the SKU used for this application gateway"
  type        = string
}

variable "sku_capacity" {
  description = "The capacity (number of instances) of the SKU used for this application gateway"
  type        = number
}


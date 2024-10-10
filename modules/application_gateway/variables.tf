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

variable "sku_tier" {
  description = "The SKU tier for the application gateway"
  type        = string
}

# Validation blocks to ensure inputs are provided
variable "backend_address_pool" {
  type        = list(object({ name = string }))
  description = "The list of backend address pools"
}

variable "backend_http_settings" {
  type = list(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
  }))
  description = "The list of backend HTTP settings"
}

variable "frontend_ip_configuration" {
  type = list(object({
    name                          = string
    public_ip_address_id          = string
    private_ip_address            = string
    private_ip_address_allocation = string
    subnet_id                     = string
  }))
  description = "The frontend IP configurations"
}

variable "gateway_ip_configuration" {
  type = list(object({
    name      = string
    subnet_id = string
  }))
  description = "The gateway IP configurations"
}

variable "frontend_port" {
  type = list(object({
    name = string
    port = number
  }))
  description = "The frontend port configurations"
}

variable "http_listener" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
  description = "The HTTP listener configurations"
}

variable "request_routing_rule" {
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
  }))
  description = "The request routing rules"
}

# Validation example
variable "sku_name" {
  type    = string
  description = "The SKU name for the application gateway"
  validation {
    condition     = length(var.sku_name) > 0
    error_message = "The SKU name must not be empty."
  }
}

variable "sku_capacity" {
  type    = number
  description = "The capacity of the application gateway"
  validation {
    condition     = var.sku_capacity > 0
    error_message = "The capacity of the application gateway must be greater than zero."
  }
}
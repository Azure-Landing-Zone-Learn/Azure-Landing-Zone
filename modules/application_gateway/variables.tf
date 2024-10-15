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

# Validation example
variable "sku_name" {
  type        = string
  description = "The SKU name for the application gateway"
  validation {
    condition     = length(var.sku_name) > 0
    error_message = "The SKU name must not be empty."
  }
}

variable "sku_capacity" {
  type        = number
  description = "The capacity of the application gateway"
  validation {
    condition     = var.sku_capacity > 0
    error_message = "The capacity of the application gateway must be greater than zero."
  }
}

variable "sku_pip" {
  type        = string
  description = "The SKU of pip"
  default     = "Standard"
}

variable "allocation_method" {
  type        = string
  description = "The allocation method for the public IP address"
  default     = "Static"
}

variable "frontend_ip_configuration" {
  type = list(object({
    name                            = string
    public_ip_address_id            = optional(string)
    private_ip_address              = optional(string)
    private_ip_address_allocation   = optional(string)
    subnet_id                       = opptional(string)
    private_link_configuration_name = optional(string)
  }))
  description = "The frontend IP configurations"
}

variable "backend_address_pool" {
  type        = list(object({ name = string }))
  description = "The list of backend address pools"
}

variable "backend_http_settings" {
  type = list(object({
    cookie_based_affinity = string
    affinity_cookie_name  = string
    name                  = string
    path                  = optional(string)
    port                  = number
    probe_name            = optional(string)
    protocol              = string
    request_timeout       = optional(number)
    host_name             = optional(string)
    pick_host_name_from_backend_http_settings = optional(bool)
  }))
  description = "The list of backend HTTP settings"
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
    host_name                      = optional(string)
  }))
  description = "The HTTP listener configurations"
}

variable "request_routing_rule" {
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = optional(string)
    backend_http_settings_name = optional(string)
    url_path_map_name          = string
    priority                   = number
  }))
  description = "The request routing rules"
}

variable "url_path_map" {
  type = list(object({
    name                                = string
    default_backend_address_pool_name   = optional(string)
    default_backend_http_settings_name  = optional(string)
    default_redirect_configuration_name = optional(string)
    default_rewrite_rule_set_name       = optional(string)
    path_rule = list(object({
      name                        = string
      paths                       = list(string)
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      redirect_configuration_name = optional(string)
      rewrite_rule_set_name       = optional(string)
    }))
  }))
}
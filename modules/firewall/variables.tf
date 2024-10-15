variable "name" {
  description = "The name of the firewall"
  type        = string
}

variable "location" {
  description = "The location where the firewall will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the firewall will be created"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the firewall"
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier for the firewall"
  type        = string
}

variable "ip_configuration" {
  type = object({
    name = string
    subnet_id = optional(string)
    public_ip_address_id = optional(string)
  })
  description = "The IP configuration for the firewall"
  default = {}
}

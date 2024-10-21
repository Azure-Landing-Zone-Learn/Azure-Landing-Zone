variable "name" {
  description = "The name of the route table"
  nullable    = false
  type        = string
}

variable "location" {
  description = "The location/region where the route table is created"
  nullable    = false
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the route table is created"
  nullable    = false
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  nullable    = false
  type        = map(any)
}

variable "ip_configuration" {
  description = "value of ip configuration"
  type = list(object({
    name                                               = string
    subnet_id                                          = optional(string)
    private_ip_address_allocation                      = string
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    public_ip_address_id                               = optional(string)
    private_ip_address_version                         = optional(string)
    primary                                            = optional(bool)
  }))
}
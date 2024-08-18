# modules/virtual_network/variables.tf

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The location/region where the virtual network is created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network is created"
  type        = string
}

variable "subnets" {
  description = "A list of subnets to be created within the virtual network"
  type = list(object({
    name            = string
    address_prefixes = list(string)
  }))
  default = []
}

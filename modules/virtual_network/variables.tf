# modules/virtual_network/variables.tf

variable "name" {
  description = "The name of the virtual network"
  nullable    = false
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  nullable    = false
  type        = list(string)
}

variable "location" {
  description = "The location/region where the virtual network is created"
  nullable    = false
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network is created"
  nullable    = false
  type        = string
}

variable "subnets" {
  description = "A list of subnets to be created within the virtual network"
  nullable    = false
}

variable "peerings" {
  description = "A list of virtual network peerings to be created"
  nullable    = true
}
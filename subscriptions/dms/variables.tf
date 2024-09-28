variable "location" {
  description = "The location where the resource group will be created"
  nullable    = false
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  nullable    = false
  type        = map(any)
}

variable "subscription_name" {
  description = "The name of the subscription"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "remote_virtual_network_id" {
  description = "The ID of the remote virtual network to peer with"
  type        = string
}
variable "name" {
  description = "The name of the network security group"
  nullable    = false
  type        = string
}

variable "location" {
  description = "The location where the network security group will be created"
  nullable    = false
  type        = string
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the Application Security Group. Changing this forces a new resource to be created."
  nullable    = false
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  nullable    = false
  type        = map(any)
}

variable "security_rules" {
  description = "(Optional) List of security_rule objects representing security rules, as defined below."
  default     = {}
}
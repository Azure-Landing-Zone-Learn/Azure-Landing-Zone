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

variable "subnet_id" {
  description = "The ID of the subnet to associate with the route table"
  nullable    = false
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  nullable    = false
  type        = map(any)
}
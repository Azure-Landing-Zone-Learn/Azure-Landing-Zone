variable "name" {
  description = "The name of the resource group"
  nullable    = false
  type        = string
}

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
variable "name" {
  description = "name of private dns zone"
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "name of resource group"
  type        = string
  nullable    = false
}

variable "record_name" {
  description = "name of record"
  type        = string
  nullable    = false
}

variable "records" {
  description = "records"
  type        = list(string)
  nullable    = false
}
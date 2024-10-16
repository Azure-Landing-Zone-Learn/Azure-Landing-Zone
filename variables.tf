# Root module variables.tf

variable "subscription_connectivity_id" {
  description = "The Azure subscription id"
  type        = string
}

variable "subscription_connectivity_name" {
  description = "The Azure subscription name of connectivity subscription"
  type        = string
  default     = "connectivity"
}
variable "location" {
  description = "The location where the resource group will be created"
  type        = string
  default     = "northeurope"
}

variable "subscription_dms_name" {
  description = "The Azure subscription name of dms subscription"
  type        = string
  default     = "dms"
}

variable "subscription_dms_id" {
  description = "The Azure subscription id"
  type        = string
}
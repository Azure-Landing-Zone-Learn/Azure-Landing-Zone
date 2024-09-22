# Root module variables.tf

variable "subscription_id" {
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
  default     = "eastasia"
}

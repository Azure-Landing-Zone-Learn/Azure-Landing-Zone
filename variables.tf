# Root module variables.tf

variable "subscription_id" {
  description = "The Azure subscription id"
  type        = string
  default     = "f3201a06-2f4e-4b3b-9a7a-7a54898ea3d2"
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

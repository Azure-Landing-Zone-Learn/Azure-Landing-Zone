variable "vm_name" {
  description = "The name of the virtual machine"
  nullable    = false
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created"
  nullable    = false
  type        = string
}

variable "location" {
  description = "The location where the VM will be created"
  nullable    = false
  type        = string
}

variable "network_interface_ids" {
  description = "The ID of the network interface"
  nullable    = false
  type        = list(string)
}

variable "os_profile_linux_config" {
  description = "The OS profile linux configuration"
  default     = false
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}

variable "os_publisher" {
  description = "The OS publisher"
  type        = string
}

variable "os_offer" {
  description = "The OS offer"
  type        = string
}

variable "os_sku" {
  description = "The OS SKU"
  type        = string
}


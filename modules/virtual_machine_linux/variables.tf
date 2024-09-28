variable "name" {
  description = "The name of the vm"
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

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  nullable    = false
  type        = map(any)
}

variable "admin_username" {
  description = "The username for the virtual machine"
  nullable    = false
  type        = string
}

variable "nics" {
  description = "list of network interfaces"
  nullable    = false
  type        = map(any)
}

variable "storage_account_type" {
  description = "The type of storage account to use for the OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "The size of the OS disk in gigabytes"
  nullable    = false
  type        = number
}

variable "os_disk_name" {
  description = "The name of the OS disk"
  nullable    = false
  type        = string
}

variable "size" {
  description = "The size of the virtual machine"
  nullable    = false
  type        = string
}

variable "admin_password" {
  description = "The password for the virtual machine"
  type        = string
  default     = null
}

variable "disable_password_authentication" {
  description = "Should password authentication be disabled for the VM"
  type        = bool
  default     = false
}

variable "public_key" {
  description = "The public key for the virtual machine"
  type        = string
  default     = null
}

variable "publisher" {
  description = "The publisher of the OS image"
  nullable    = false
  type        = string
}

variable "offer" {
  description = "The offer of the OS image"
  nullable    = false
  type        = string
}

variable "sku" {
  description = "The SKU of the OS image"
  nullable    = false
  type        = string
}

variable "tags" {
  description = "value of tags"
  type        = map(any)
}

variable "image_version" {
  description = "The version of the OS image"
  type        = string
  default     = "latest"
}

variable "computer_name" {
  description = "The computer name of the virtual machine"
  type        = string
  default     = null
}

variable "caching" {
  description = "The caching type of the OS disk"
  type        = string
  default     = "ReadWrite"
}
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
  default     = ["10.0.0.0/16"]
}

variable "remote_virtual_network_id" {
  description = "The ID of the remote virtual network to peer with"
  type        = string
}

variable "bastion_pip_name" {
  description = "The name of the public IP address for the bastion host"
  type        = string
  default     = "bastion-pip"
}

variable "fw_pip_name" {
  description = "The name of the public IP address for the firewall"
  type        = string
  default     = "fw-pip"
}

variable "allocation_method" {
  description = "The allocation method for the public IP address"
  type        = string
  default     = "Static"
}

variable "sku_pip" {
  description = "The SKU of pip"
  type        = string
  default     = "Standard"
}

variable "ip_configuration_name" {
  description = "The name of the ip configuration"
  type        = string
  default     = "ipconfig"
}

variable "allowed_to_internet_vms_dms" {
  description = "vms from dms that are allowed to access the internet"
  type        = list(string)
}

variable "allow_ssh_to_dms_vms" {
  description = "Allow SSH traffic to DMS VM"
  type        = list(string)
}
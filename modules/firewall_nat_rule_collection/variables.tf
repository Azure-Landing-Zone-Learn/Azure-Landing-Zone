variable "name" {
  description = "value of dnat rc name"
  type        = string
}

variable "resource_group_name" {
  description = "value of resource group name"
  type        = string
}

variable "firewall_name" {
  description = "value of firewall name"
  type        = string
}

variable "priority" {
  description = "value of priority"
  type        = number
}

variable "action" {
  description = "value of action"
  type        = string
  default     = "Dnat"
}

variable "rule" {
  description = "value of dnat rule"
  type = list(object({
    name                  = string
    description           = string
    source_addresses      = list(string)
    source_ip_groups      = list(string)
    destination_addresses = list(string)
    destination_ip_groups = list(string)
    destination_fqdns     = list(string)
    destination_ports     = list(string)
    protocols             = list(string)
  }))
}
variable "name" {
  description = "The name of the network rule collection"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the network rule collection will be created"
  type        = string
}

variable "firewall_name" {
  description = "The name of the Azure Firewall"
  type        = string
}

variable "action" {
  description = "The action to apply to the rule collection"
  type        = string
}

variable "priority" {
  description = "The priority of the rule collection"
  type        = number
}

variable "rule" {
  description = "The rule to apply to the rule collection"
}

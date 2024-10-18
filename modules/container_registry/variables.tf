variable "name" {
    description = "The name of the acr"
    type        = string
}

variable "location" {
    description = "The location/region where the acr will be created"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which the acr will be created"
    type        = string
}

variable "sku" {
    description = "The SKU of the acr"
    type        = string
}

variable "admin_enabled" {
    description = "Is admin enabled for the acr"
    type        = bool
}

variable "pe_name" {
    description = "The name of the private endpoint"
    type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet in which the private endpoint will be created"
    type        = string
}

variable "private_service_connection" {
    description = "The private service connection configuration"
    type = object({
        name                           = string
        private_connection_resource_id = string
        is_manual_connection           = bool
    })
}
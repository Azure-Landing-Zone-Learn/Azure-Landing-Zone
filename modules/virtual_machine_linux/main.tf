module "nics" {
  source = "../../modules/network_interface"

  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id
  tags                = var.tags
}

/* resource "azurerm_linux_virtual_machine" "linux_vm" {
    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name

   admin_username = var.admin_username
   network_interface_ids = { for idx, nic in module.nics : idx => nic.id }
} */

output "nic_ids" {
  value = [for nic in module.nics : nic.id]
}
locals {
  subnets = [
    {
      name             = "subnet-${var.subscription_name}-${var.location}-001"
      address_prefixes = ["10.1.0.0/24"]
      route_table_id   = module.route_table_subnet_001.id
    },
    {
      name             = "subnet-${var.subscription_name}-${var.location}-002"
      address_prefixes = ["10.1.1.0/24"]
    },
    {
      name             = "subnet-agw-${var.subscription_name}-${var.location}"
      address_prefixes = ["10.1.2.0/24"]
    },
    {
      name             = "subnet-acr-${var.subscription_name}-${var.location}"
      address_prefixes = ["10.1.3.0/24"]
    },
    {
      name             = "subnet-cicd-${var.subscription_name}-${var.location}"
      address_prefixes = ["10.1.4.0/24"]
      route_table_id   = module.route_table_subnet_cicd.id
    },
    {
      name             = "subnet-jump-${var.subscription_name}-${var.location}"
      address_prefixes = ["10.1.5.0/24"]
    },
    {
      name             = "subnet-mssql-${var.subscription_name}-${var.location}"
      address_prefixes = ["10.1.6.0/24"]
    }
  ]
  peerings = [
    {
      name                      = "vnet-peer-${var.subscription_name}-to-connectivity"
      resource_group_name       = module.rg.name
      remote_virtual_network_id = var.remote_virtual_network_id
      allow_forwarded_traffic   = true
    }
  ]

  network_interfaces = [
    {
      name = "nic-fe-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = null
        }
      ]
      tags = var.tags
    },
    {
      name = "nic-be-get-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = null
        }
      ]
      tags = var.tags
    },
    {
      name = "nic-be-post-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = null
        }
      ]
      tags = var.tags
    },
    {
      name = "nic-be-update-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = null
        }
      ]
      tags = var.tags
    },
    {
      name = "nic-be-delete-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = null
        }
      ]
      tags = var.tags
    },
    {
      name = "nic-jumphost-${var.subscription_name}-${var.location}"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          subnet_id                     = module.vnet.subnets["subnet-jump-${var.subscription_name}-${var.location}"]
          private_ip_address_allocation = "Dynamic"
          public_ip_address_id          = module.jumpbox_pip.id
        }
      ]
      tags = var.tags
    }
  ]

  linux_virtual_machines = [
    {
      vm_name                         = "vm-fe-${var.subscription_name}-${var.location}"
      vm_size                         = "STANDARD_DS1_V2"
      admin_username                  = "tung"
      os_disk_name                    = "os-disk-${var.subscription_name}-${var.location}-001"
      os_publisher                    = "Canonical"
      os_offer                        = "UbuntuServer"
      os_sku                          = "16.04-LTS"
      computer_name                   = "Tung macbook 1"
      disk_size_gb                    = 30
      disable_password_authentication = false
      nics                            = { "${local.network_interfaces[0].name}" = local.network_interfaces[0] }
    },
    {
      vm_name                         = "vm-be-get-${var.subscription_name}-${var.location}"
      vm_size                         = "STANDARD_DS1_V2"
      admin_username                  = "tung"
      os_disk_name                    = "os-disk-${var.subscription_name}-${var.location}-002"
      os_publisher                    = "Canonical"
      os_offer                        = "UbuntuServer"
      os_sku                          = "16.04-LTS"
      computer_name                   = "Tung macbook 2"
      disk_size_gb                    = 30
      disable_password_authentication = false
      nics                            = { "${local.network_interfaces[1].name}" = local.network_interfaces[1] }
    },
    {
      vm_name                         = "vm-be-post-${var.subscription_name}-${var.location}"
      vm_size                         = "STANDARD_DS1_V2"
      admin_username                  = "tung"
      os_disk_name                    = "os-disk-${var.subscription_name}-${var.location}-003"
      os_publisher                    = "Canonical"
      os_offer                        = "UbuntuServer"
      os_sku                          = "16.04-LTS"
      computer_name                   = "Tung macbook 3"
      disk_size_gb                    = 30
      disable_password_authentication = false
      nics                            = { "${local.network_interfaces[2].name}" = local.network_interfaces[2] }
    },
    {
      vm_name                         = "vm-be-update-${var.subscription_name}-${var.location}"
      vm_size                         = "STANDARD_DS1_V2"
      admin_username                  = "tung"
      os_disk_name                    = "os-disk-${var.subscription_name}-${var.location}-004"
      os_publisher                    = "Canonical"
      os_offer                        = "UbuntuServer"
      os_sku                          = "16.04-LTS"
      computer_name                   = "Tung macbook 4"
      disk_size_gb                    = 30
      disable_password_authentication = false
      nics                            = { "${local.network_interfaces[3].name}" = local.network_interfaces[3] }
    },
    {
      vm_name                         = "vm-be-delete-${var.subscription_name}-${var.location}"
      vm_size                         = "STANDARD_DS1_V2"
      admin_username                  = "tung"
      os_disk_name                    = "os-disk-${var.subscription_name}-${var.location}-005"
      os_publisher                    = "Canonical"
      os_offer                        = "UbuntuServer"
      os_sku                          = "16.04-LTS"
      computer_name                   = "Tung macbook 5"
      disk_size_gb                    = 30
      disable_password_authentication = false
      nics                            = { "${local.network_interfaces[4].name}" = local.network_interfaces[4] }
    }
  ]

    window_virtual_machines = [
    {
      vm_name        = "vm-jumphost-${var.subscription_name}-${var.location}"
      vm_size        = "STANDARD_DS1_V2"
      admin_username = "tung"
      computer_name  = "TungMacbook4"
      os_disk_name   = "os-disk-${var.subscription_name}-${var.location}-006"
      os_publisher   = "MicrosoftWindowsServer"
      os_offer       = "WindowsServer"
      os_sku         = "2019-Datacenter"
      disk_size_gb   = 127
      nics           = { "${local.network_interfaces[5].name}" = local.network_interfaces[5] }
    }
  ]

  cicd_rt_routes = [
    {
      name                   = "route-to-internet"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.fw_private_ip_address
    }
  ]

  snet1_rt_routes = [
    {
      name                   = "from-ssh-to-vm"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.fw_private_ip_address
    }
  ]
}

module "rg" {
  source = "../../modules/resource_group"

  name     = "rg-${var.subscription_name}-${var.location}-001"
  location = var.location
  tags     = var.tags
}

module "jumpbox_pip" {
  source = "../../modules/public_ip"

  name                = "jumpbox-pip-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "vnet" {
  source = "../../modules/virtual_network"

  name                = "vnet-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  address_space       = var.address_space
  subnets             = { for subnet in local.subnets : subnet.name => subnet }
  peerings            = { for peering in local.peerings : peering.name => peering }
}

resource "random_password" "linux_server_password" {
  for_each    = { for vm in local.linux_virtual_machines : vm.vm_name => vm }
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = false
}

module "linux_vms" {
  source = "../../modules/virtual_machine_linux"

  for_each = { for vm in local.linux_virtual_machines : vm.vm_name => vm }

  name                = each.value.vm_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = var.tags
  size                = each.value.vm_size
  computer_name       = each.value.computer_name
  admin_username      = each.value.admin_username
  admin_password      = random_password.linux_server_password[each.key].result
  os_disk_name        = each.value.os_disk_name
  publisher           = each.value.os_publisher
  offer               = each.value.os_offer
  sku                 = each.value.os_sku
  nics                = each.value.nics
  disk_size_gb        = each.value.disk_size_gb
}

resource "random_password" "window_server_password" {
  for_each    = { for vm in local.window_virtual_machines : vm.vm_name => vm }
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = false
}

module "window_vms" {
  source = "../../modules/virtual_machine_window"

  for_each = { for vm in local.window_virtual_machines : vm.vm_name => vm }

  name                = each.value.vm_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = var.tags
  size                = each.value.vm_size
  computer_name       = each.value.computer_name
  admin_username      = each.value.admin_username
  admin_password      = random_password.window_server_password[each.key].result
  os_disk_name        = each.value.os_disk_name
  publisher           = each.value.os_publisher
  offer               = each.value.os_offer
  sku                 = each.value.os_sku
  nics                = each.value.nics
  disk_size_gb        = each.value.disk_size_gb
}

module "agw_pip" {
  source = "../../modules/public_ip"

  name                = "agw-pip-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "agw" {
  source = "../../modules/application_gateway"

  name                = "agw-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name

  sku_name     = "Standard_v2"
  sku_tier     = "Standard_v2"
  sku_capacity = 2

  frontend_ip_configuration = [
    {
      name                            = "frontend-ip-${var.subscription_name}-${var.location}-001"
      subnet_id                       = null
      private_ip_address              = null
      public_ip_address_id            = module.agw_pip.id
      private_ip_address_allocation   = null
      private_link_configuration_name = null
    }
  ]

  backend_address_pool = [
    {
      name = "backend-address-pool-todo-app"
      ip_addresses = [
        module.linux_vms["vm-fe-${var.subscription_name}-${var.location}"].private_ip_addresses[0],
        module.linux_vms["vm-be-get-${var.subscription_name}-${var.location}"].private_ip_addresses[0],
        module.linux_vms["vm-be-post-${var.subscription_name}-${var.location}"].private_ip_addresses[0],
        module.linux_vms["vm-be-update-${var.subscription_name}-${var.location}"].private_ip_addresses[0],
        module.linux_vms["vm-be-delete-${var.subscription_name}-${var.location}"].private_ip_addresses[0]
      ]
    }
  ]

  backend_http_settings = [
    {
      name                  = "backend-http-settings-todo-app"
      cookie_based_affinity = "Disabled"
      port                  = 80
      protocol              = "Http"
    }
  ]

  gateway_ip_configuration = [
    {
      name      = "gateway-ip-configuration-${var.subscription_name}-${var.location}-001"
      subnet_id = module.vnet.subnets["subnet-agw-${var.subscription_name}-${var.location}"]
    }
  ]

  frontend_port = [
    {
      name = "frontend-port-${var.subscription_name}-${var.location}-001"
      port = 80
    }
  ]

  http_listener = [
    {
      name                           = "http-listener-${var.subscription_name}-${var.location}-001"
      frontend_ip_configuration_name = "frontend-ip-${var.subscription_name}-${var.location}-001"
      frontend_port_name             = "frontend-port-${var.subscription_name}-${var.location}-001"
      protocol                       = "Http"
    }
  ]

  request_routing_rule = [
    {
      name               = "routing-rule"
      rule_type          = "PathBasedRouting"
      http_listener_name = "http-listener-${var.subscription_name}-${var.location}-001"
      url_path_map_name  = "url-path-map-${var.subscription_name}-${var.location}-001"
      priority           = 1
    }
  ]

  url_path_map = [
    {
      name                               = "url-path-map-${var.subscription_name}-${var.location}-001"
      default_backend_address_pool_name  = "backend-address-pool-todo-app"
      default_backend_http_settings_name = "backend-http-settings-todo-app"
      path_rule = [
        {
          name                       = "path-rule-todo-app"
          paths                      = ["/todoapi/*"]
          backend_address_pool_name  = "backend-address-pool-todo-app"
          backend_http_settings_name = "backend-http-settings-todo-app"
        }
      ]
    }
  ]
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "agw_backend_address_pool_association" {
  for_each = {
    fe_vm_nic = {
      network_interface_id = module.linux_vms["vm-fe-${var.subscription_name}-${var.location}"].network_interface_ids[0]
      backend_pool_name    = "backend-address-pool-todo-app"
    },
    be_get_vm_nic = {
      network_interface_id = module.linux_vms["vm-be-get-${var.subscription_name}-${var.location}"].network_interface_ids[0]
      backend_pool_name    = "backend-address-pool-todo-app"
    },
    be_post_vm_nic = {
      network_interface_id = module.linux_vms["vm-be-post-${var.subscription_name}-${var.location}"].network_interface_ids[0]
      backend_pool_name    = "backend-address-pool-todo-app"
    },
    be_update_vm_nic = {
      network_interface_id = module.linux_vms["vm-be-update-${var.subscription_name}-${var.location}"].network_interface_ids[0]
      backend_pool_name    = "backend-address-pool-todo-app"
    },
    be_delete_vm_nic = {
      network_interface_id = module.linux_vms["vm-be-delete-${var.subscription_name}-${var.location}"].network_interface_ids[0]
      backend_pool_name    = "backend-address-pool-todo-app"
    }

  }

  network_interface_id  = each.value.network_interface_id
  ip_configuration_name = "ipconfig1" # Assuming this is the default IP configuration name

  # Find the correct backend pool ID based on the name
  backend_address_pool_id = lookup({ for pool in module.agw.backend_address_pool : pool.name => pool.id }, each.value.backend_pool_name)
}

module "developer_bastion" {
  source = "../../modules/bastion"

  name                   = "bastion-${var.subscription_name}-${var.location}-001"
  location               = var.location
  resource_group_name    = module.rg.name
  sku                    = "Developer"
  public_ip_address_name = null
  virtual_network_id     = module.vnet.id
}

module "public_acr" {
  source = "../../modules/container_registry"

  name                          = "publicacr${var.subscription_name}${var.location}"
  location                      = var.location
  resource_group_name           = module.rg.name
  sku                           = "Basic"
  admin_enabled                 = true
  public_network_access_enabled = true
  is_private                    = false
}


module "route_table_subnet_cicd" {
  source = "../../modules/route_table"

  name                = "rt-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  routes              = local.cicd_rt_routes
  tags                = var.tags
}

module "route_table_subnet_001" {
  source = "../../modules/route_table"

  name                = "rt-${var.subscription_name}-${var.location}-002"
  location            = var.location
  resource_group_name = module.rg.name
  routes              = local.snet1_rt_routes
  tags                = var.tags
}

resource "random_password" "mssql_server_password" {
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = false
}

module "mssql_server" {
  source = "../../modules/mssql-server"

  name                         = "mssqlserver-${var.subscription_name}-${var.location}-001"
  location                     = var.location
  resource_group_name          = module.rg.name
  administrator_login          = "tung"
  administrator_login_password = random_password.mssql_server_password.result

  is_private          = true
  subnet_id           = module.vnet.subnets["subnet-mssql-${var.subscription_name}-${var.location}"]
  vnet_id             = module.vnet.id
  virtual_network_rules = [
    {
      name = "vnet-rule1"
      subnet_id   = module.vnet.subnets["subnet-jump-${var.subscription_name}-${var.location}"]
    }
  ]
}

module "private_mssql" {
  source = "../../modules/mssql"

  name                = "mssql-${var.subscription_name}-${var.location}-001"
  server_id           = module.mssql_server.id
}

output "vnet_id" {
  value = module.vnet.id
}

output "allowed_to_internet_vms_dms" {
  value = [
    module.linux_vms["vm-be-get-${var.subscription_name}-${var.location}"].private_ip_addresses[0]
  ]
}

output "allowed_ssh_to_dms_vms" {
  value = [
    module.linux_vms["vm-be-get-${var.subscription_name}-${var.location}"].private_ip_addresses[0]
  ]
}
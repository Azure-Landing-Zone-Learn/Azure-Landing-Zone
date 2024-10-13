locals {
  subnets = [
    {
      name             = "subnet-${var.subscription_name}-${var.location}-001"
      address_prefixes = ["10.1.0.0/24"]
    },
    {
      name             = "subnet-${var.subscription_name}-${var.location}-002"
      address_prefixes = ["10.1.1.0/24"]
    },
    {
      name             = "subnet-${var.subscription_name}-${var.location}-003"
      address_prefixes = ["10.1.2.0/24"]
    },
    {
      name             = "subnet-${var.subscription_name}-${var.location}-004"
      address_prefixes = ["10.1.3.0/29"]
    },
    {
      name             = "subnet-agw-${var.subscription_name}-${var.location}-001"
      address_prefixes = ["10.1.4.0/29"]
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
      name      = "nic-${var.subscription_name}-${var.location}-001"
      subnet_id = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-001"]
      tags      = var.tags
    },
    {
      name      = "nic-${var.subscription_name}-${var.location}-002"
      subnet_id = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-002"]
      tags      = var.tags
    },
    {
      name      = "nic-${var.subscription_name}-${var.location}-003"
      subnet_id = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-003"]
      tags      = var.tags
    },
    {
      name      = "nic-${var.subscription_name}-${var.location}-004"
      subnet_id = module.vnet.subnets["subnet-${var.subscription_name}-${var.location}-004"]
      tags      = var.tags
    }
  ]

  linux_virtual_machines = [
    {
      vm_name                         = "vm-${var.subscription_name}-${var.location}-001"
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
      vm_name                         = "vm-${var.subscription_name}-${var.location}-002"
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
      vm_name                         = "vm-${var.subscription_name}-${var.location}-003"
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
    }
  ]
  window_virtual_machines = [
    {
      vm_name        = "vm-${var.subscription_name}-${var.location}-004"
      vm_size        = "STANDARD_DS1_V2"
      admin_username = "tung"
      computer_name  = "TungMacbook4"
      os_disk_name   = "os-disk-${var.subscription_name}-${var.location}-004"
      os_publisher   = "MicrosoftWindowsServer"
      os_offer       = "WindowsServer"
      os_sku         = "2019-Datacenter"
      disk_size_gb   = 127
      nics           = { "${local.network_interfaces[3].name}" = local.network_interfaces[3] }
    }
  ]

  agw = {
    name               = "agw-${var.subscription_name}-${var.location}-001"
    sku_name           = "Standard_v2"
    sku_tier           = "Standard_v2"
    sku_capacity       = 2
    virtual_network_id = module.vnet.id
    subnet_id          = module.vnet.subnets["subnet-agw-${var.subscription_name}-${var.location}-001"]

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

    # Define two backend pools: one for Application 1 (VM1, VM2), and another for Application 2 (VM3, VM4)
    backend_address_pool = [
      {
        name = "backend-address-pool-app1"
        ip_addresses = [
          module.linux_vms["vm-${var.subscription_name}-${var.location}-001"].private_ip_addresses[0],
          module.linux_vms["vm-${var.subscription_name}-${var.location}-002"].private_ip_addresses[0]
        ]
      },
      {
        name = "backend-address-pool-app2"
      }
    ]

    # HTTP settings for each backend pool
    backend_http_settings = [
      {
        name                  = "backend-http-settings-app1"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
      },
      {
        name                  = "backend-http-settings-app2"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
      }
    ]

    gateway_ip_configuration = [
      {
        name      = "gateway-ip-configuration-${var.subscription_name}-${var.location}-001"
        subnet_id = module.vnet.subnets["subnet-agw-${var.subscription_name}-${var.location}-001"]
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
        name                       = "routing-rule-app1"
        rule_type                  = "PathBasedRouting"
        http_listener_name         = "http-listener-${var.subscription_name}-${var.location}-001"
        backend_address_pool_name  = "backend-address-pool-app1"
        backend_http_settings_name = "backend-http-settings-app1"
        paths                      = ["/api1/*", "/api2/*"]
      },
      {
        name                       = "routing-rule-app2"
        rule_type                  = "PathBasedRouting"
        http_listener_name         = "http-listener-${var.subscription_name}-${var.location}-001"
        backend_address_pool_name  = "backend-address-pool-app2"
        backend_http_settings_name = "backend-http-settings-app2"
        paths                      = ["/api3/*", "/api4/*"]
      }
    ]

    url_path_map = [
      {
        name                              = "url-path-map-${var.subscription_name}-${var.location}-001"
        default_backend_pool_id           = module.agw.backend_address_pool[0].id
        default_http_settings_id          = module.agw.backend_http_settings[0].id
        default_redirect_configuration_id = null
        default_rewrite_rule_set_id       = null
        path_rules = [
          {
            name                      = "path-rule-app1"
            paths                     = ["/api1/*", "/api2/*"]
            backend_pool_id           = module.agw.backend_address_pool[0].id
            http_settings_id          = module.agw.backend_http_settings[0].id
            redirect_configuration_id = null
            rewrite_rule_set_id       = null
          },
          {
            name                      = "path-rule-app2"
            paths                     = ["/api3/*", "/api4/*"]
            backend_pool_id           = module.agw.backend_address_pool[1].id
            http_settings_id          = module.agw.backend_http_settings[1].id
            redirect_configuration_id = null
            rewrite_rule_set_id       = null
          }
        ]
      }
    ]
  }

  agw_pip = {
    name                = "agw-pip-${var.subscription_name}-${var.location}-001"
    location            = var.location
    resource_group_name = module.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

module "agw_pip" {
  source = "../../modules/public_ip"

  name                = local.agw_pip.name
  location            = local.agw_pip.location
  resource_group_name = local.agw_pip.resource_group_name
  allocation_method   = local.agw_pip.allocation_method
  sku                 = local.agw_pip.sku
}

module "agw" {
  source = "../../modules/application_gateway"

  name     = local.agw.name
  location = var.location

  resource_group_name = module.rg.name

  sku_name     = local.agw.sku_name
  sku_tier     = local.agw.sku_tier
  sku_capacity = local.agw.sku_capacity

  frontend_ip_configuration = local.agw.frontend_ip_configuration
  backend_address_pool      = local.agw.backend_address_pool
  backend_http_settings     = local.agw.backend_http_settings
  gateway_ip_configuration  = local.agw.gateway_ip_configuration
  frontend_port             = local.agw.frontend_port
  http_listener             = local.agw.http_listener
  request_routing_rule      = local.agw.request_routing_rule
  url_path_map              = local.agw.url_path_map
}


module "rg" {
  source = "../../modules/resource_group"

  name     = "rg-${var.subscription_name}-${var.location}-001"
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source = "../../modules/virtual_network"

  name                = "vnet-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  address_space       = var.address_space
  subnets             = { for subnet in local.subnets : subnet.name => subnet }
  //peerings            = { for peering in local.peerings : peering.name => peering }
  peerings = null
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

resource "random_password" "window_server_password" {
  for_each    = { for vm in local.window_virtual_machines : vm.vm_name => vm }
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

module "window_vms" {
  source = "../../modules/virtual_machine_window"

  for_each = { for vm in local.window_virtual_machines : vm.vm_name => vm }

  name                = each.value.vm_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = var.tags
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = random_password.window_server_password[each.key].result
  computer_name       = each.value.computer_name
  os_disk_name        = each.value.os_disk_name
  publisher           = each.value.os_publisher
  offer               = each.value.os_offer
  sku                 = each.value.os_sku
  nics                = each.value.nics
  disk_size_gb        = each.value.disk_size_gb
}

module "developer_bastion" {
  source = "../../modules/bastion"

  name                = "bastion-${var.subscription_name}-${var.location}-001"
  location            = var.location
  resource_group_name = module.rg.name
  sku                 = "Developer"
  virtual_network_id  = module.vnet.id
}


output "vnet_id" {
  value = module.vnet.id
}

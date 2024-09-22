for_each only works with map, not list
for ... in ... works with list


    {
      name                       = "AllowMyIpAddressCustom8080Inbound"
      protocol                   = "*"
      access                     = "Allow"
      priority                   = 100
      direction                  = "Inbound"
      source_address_prefix      = "89.244.82.247"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "8080"
    }
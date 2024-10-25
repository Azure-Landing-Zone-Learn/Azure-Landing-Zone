1. gateway_ip_configuration

```
gateway_ip_configuration = [
  {
    name      = "gateway-ip-configuration-${var.subscription_name}-${var.location}-001"
    subnet_id = module.vnet.subnets["subnet-agw-${var.subscription_name}-${var.location}-001"]
  }
]
```
Purpose: The gateway_ip_configuration defines the network configuration that the Application Gateway will use to communicate with other resources in the Virtual Network.

name: A unique name for this gateway IP configuration.

subnet_id: The specific subnet from your Virtual Network (VNet) where the Application Gateway is deployed. This must be a dedicated subnet for the Application Gateway, in this case, it's "subnet-agw-${var.subscription_name}-${var.location}-001". No other resources should share this subnet.

The Application Gateway needs this configuration to route traffic between its frontend (public-facing side) and backend pools (where your VMs reside).


2. frontend_port

```
frontend_port = [
  {
    name = "frontend-port-${var.subscription_name}-${var.location}-001"
    port = 80
  }
]

```

Purpose: The frontend_port defines the public-facing port on which the Application Gateway listens for incoming traffic.

name: A unique name for this frontend port configuration.

port: The specific port that will accept incoming traffic. In this case, port 80 is defined, which is the default port for HTTP traffic.

This configuration specifies that the Application Gateway will listen for HTTP requests on port 80.


3. http_listener

```
http_listener = [
  {
    name                           = "http-listener-${var.subscription_name}-${var.location}-001"
    frontend_ip_configuration_name = "frontend-ip-${var.subscription_name}-${var.location}-001"
    frontend_port_name             = "frontend-port-${var.subscription_name}-${var.location}-001"
    protocol                       = "Http"
  }
]
```
Purpose: The http_listener component binds the Application Gateway's frontend configuration (IP and port) to a specific protocol (HTTP or HTTPS). It listens for incoming requests on the specified frontend IP address and port.

name: A unique name for the listener.

frontend_ip_configuration_name: This links the listener to the frontend IP configuration of the Application Gateway, which defines whether the gateway uses a public or private IP address. Here, the configuration is tied to "frontend-ip-${var.subscription_name}-${var.location}-001", which is defined earlier with a public IP.

frontend_port_name: This ties the listener to the port it will listen on, which is "frontend-port-${var.subscription_name}-${var.location}-001", configured on port 80 for HTTP traffic.

protocol: Defines the protocol to use. Here it’s "Http", meaning the listener is accepting HTTP traffic (as opposed to HTTPS).
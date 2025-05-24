locals {
  firewall_subnet_cidr = cidrsubnet(var.vnet_address_space, 8, 1) # Generates 10.0.1.0/24
}

locals {
  resource_prefix      = "cmtr-eh8dj90z-mod9"
  vnet_address_space   = var.vnet_address_space
  firewall_subnet_cidr = cidrsubnet(local.vnet_address_space, 8, 1) # Generates 10.0.1.0/24
}

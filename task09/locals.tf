locals {
  resource_prefix      = "cmtr-eh8dj90z-mod9"
  vnet_address_space   = "10.0.0.0/16"
  firewall_subnet_cidr = cidrsubnet(local.vnet_address_space, 8, 1) # Generates 10.0.1.0/24
}

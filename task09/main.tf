module "afw" {
  source                 = "./modules/afw"
  resource_prefix        = var.resource_prefix
  resource_group_name    = var.resource_group_name
  location               = var.location
  vnet_name              = var.vnet_name
  vnet_address_space     = var.vnet_address_space
  firewall_subnet_prefix = local.firewall_subnet_cidr
  aks_subnet_name        = var.aks_subnet_name
  aks_loadbalancer_ip    = var.aks_loadbalancer_ip
  app_rule_collections   = var.app_rule_collections
}

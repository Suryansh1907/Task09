module "afw" {
  source              = "./modules/afw"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  aks_subnet_name     = var.aks_subnet_name
  aks_loadbalancer_ip = var.aks_loadbalancer_ip
}

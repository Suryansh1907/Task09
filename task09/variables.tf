variable "resource_group_name" {
  description = "The name of the existing resource group where the Azure Firewall and related resources will be deployed."
  type        = string
  default     = "cmtr-eh8dj90z-mod9-rg"
}

variable "location" {
  description = "The Azure region where the Azure Firewall and related resources will be deployed."
  type        = string
  default     = "westus2"
}

variable "vnet_name" {
  description = "The name of the existing virtual network where the Azure Firewall subnet will be created."
  type        = string
  default     = "cmtr-eh8dj90z-mod9-vnet"
}

variable "aks_subnet_name" {
  description = "The name of the existing AKS subnet to associate with the route table for routing traffic through the Azure Firewall."
  type        = string
  default     = "aks-snet"
}

variable "aks_loadbalancer_ip" {
  description = "The public IP address of the AKS load balancer, used for DNAT rules to route traffic through the Azure Firewall."
  type        = string
}

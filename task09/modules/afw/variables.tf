variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing virtual network"
  type        = string
}

variable "firewall_subnet_prefix" {
  description = "Address prefix for the Azure Firewall subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "aks_subnet_name" {
  description = "Name of the existing AKS subnet"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "Public IP address of the AKS load balancer"
  type        = string
}

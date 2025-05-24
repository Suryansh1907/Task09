variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cmtr-eh8dj90z-mod9-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus2"
}

variable "vnet_name" {
  description = "Name of the existing virtual network"
  type        = string
  default     = "cmtr-eh8dj90z-mod9-vnet"
}

variable "aks_subnet_name" {
  description = "Name of the existing AKS subnet"
  type        = string
  default     = "aks-snet"
}

variable "aks_loadbalancer_ip" {
  description = "Public IP address of the AKS load balancer"
  type        = string
}

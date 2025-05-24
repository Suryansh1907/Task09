variable "resource_group_name" {
  description = "The name of the existing resource group where the Azure Firewall and related resources will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the Azure Firewall and related resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "The name of the existing virtual network where the Azure Firewall subnet will be created."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the existing virtual network, used to calculate the firewall subnet address."
  type        = string
}

variable "aks_subnet_name" {
  description = "The name of the existing AKS subnet to associate with the route table for routing traffic through the Azure Firewall."
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "The public IP address of the AKS load balancer, used for DNAT rules to route traffic through the Azure Firewall."
  type        = string
}

variable "app_rule_collections" {
  description = "A map of application rule collections for the Azure Firewall, defining allowed FQDNs and protocols."
  type        = map(any)
}

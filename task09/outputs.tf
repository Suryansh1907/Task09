output "azure_firewall_public_ip" {
  description = "The public IP address of the Azure Firewall, used for accessing the NGINX service through the firewall."
  value       = module.afw.firewall_public_ip
}

output "azure_firewall_private_ip" {
  description = "The private IP address of the Azure Firewall, used as the next hop for routing AKS subnet traffic."
  value       = module.afw.firewall_private_ip
}

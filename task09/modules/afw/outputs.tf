output "firewall_public_ip" {
  description = "The public IP address assigned to the Azure Firewall, used for inbound traffic routing."
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "firewall_private_ip" {
  description = "The private IP address of the Azure Firewall, used as the next hop for routing AKS subnet traffic."
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

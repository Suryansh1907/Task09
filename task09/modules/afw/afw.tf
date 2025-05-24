resource "azurerm_subnet" "firewall_subnet" {
  name                 = "${local.resource_prefix}-afw-snet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.firewall_subnet_prefix]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = "${local.resource_prefix}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "firewall" {
  name                = "${local.resource_prefix}-afw"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewall_ip_config"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

resource "azurerm_route_table" "firewall_rt" {
  name                          = "${local.resource_prefix}-rt"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = true

  route {
    name                   = "to_firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}/subnets/${var.aks_subnet_name}"
  route_table_id = azurerm_route_table.firewall_rt.id
}

data "azurerm_subscription" "current" {}

resource "azurerm_firewall_application_rule_collection" "app_rules" {
  name                = "${local.resource_prefix}-app-rc"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name             = "allow_aks_services"
    source_addresses = ["10.0.0.0/24"]
    target_fqdns = [
      "*.azmk8s.io",
      "mcr.microsoft.com",
      "*.data.mcr.microsoft.com",
      "*.cdn.mscr.io",
      "*.docker.io",
      "registry-1.docker.io",
      "*.blob.core.windows.net",
      "*.servicebus.windows.net",
    ]
    protocol {
      port = "443"
      type = "Https"
    }
    protocol {
      port = "80"
      type = "Http"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "net_rules" {
  name                = "${local.resource_prefix}-net-rc"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "allow_aks_network"
    source_addresses      = ["10.0.0.0/24"]
    destination_addresses = ["AzureCloud"]
    destination_ports     = ["443", "80"]
    protocols             = ["TCP"]
  }
}

resource "azurerm_firewall_nat_rule_collection" "nat_rules" {
  name                = "${local.resource_prefix}-nat-rc"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "dnat_nginx"
    source_addresses      = ["*"]
    destination_ports     = ["80"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    translated_port       = 80
    translated_address    = var.aks_loadbalancer_ip
    protocols             = ["TCP"]
  }
}

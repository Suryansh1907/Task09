resource_prefix     = "cmtr-eh8dj90z-mod9"
resource_group_name = "cmtr-eh8dj90z-mod9-rg"
location            = "westus2"
vnet_name           = "cmtr-eh8dj90z-mod9-vnet"
vnet_address_space  = "10.0.0.0/16"
aks_subnet_name     = "aks-snet"
aks_loadbalancer_ip = "4.155.155.132"
app_rule_collections = {
  "aks-services" = {
    name     = "cmtr-eh8dj90z-mod9-app-rc"
    priority = 100
    action   = "Allow"
    rules = [
      {
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
        protocols = [
          { port = "443", type = "Https" },
          { port = "80", type = "Http" }
        ]
      }
    ]
  }
}

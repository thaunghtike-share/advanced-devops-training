vnets = {
  "mahar-vnet" = {
    address_space = ["10.224.0.0/12"]
    subnets = {
      "default" = {
        address_prefixes  = ["10.224.0.0/16"]
        service_endpoints = ["Microsoft.ContainerRegistry", "Microsoft.Sql", "Microsoft.Storage"]
      }
    }
  },
  "vpn-vnet" = {
    address_space = ["10.20.0.0/16"]
    subnets = {
      "default" = {
        address_prefixes = ["10.20.1.0/24"]
      }
    }
  }
}
vms = {
  "OPENVPN-SERVER" = {
    size           = "Standard_B2ms"
    subnet_key     = "vpn-vnet.default"
    admin_username = "ubuntu"

    additional_inbound_rules = [
      {
        name     = "Allow-All-Inbound"
        priority = 110
        protocol = "*"
        port     = "*"
        source   = "*"
      }
    ]
  }
}
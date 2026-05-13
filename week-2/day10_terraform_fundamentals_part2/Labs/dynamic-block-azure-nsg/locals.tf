locals {
  nsg_rules = [
    {
      name                   = "allow-ssh"
      priority               = 100
      destination_port_range = "22"
    },
    {
      name                   = "allow-http"
      priority               = 110
      destination_port_range = "80"
    }
  ]
}

variable "vms" {
  type = map(object({
    size           = string
    subnet_key     = string
    admin_username = string
    additional_inbound_rules = list(object({
      name     = string
      priority = number
      protocol = string
      port     = string
      source   = string
    }))
  }))
}
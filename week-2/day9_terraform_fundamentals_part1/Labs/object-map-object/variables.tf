variable "single_vm" {
  description = "One VM object example"

  type = object({
    name = string
    size = string
  })

  default = {
    name = "vm-dev"
    size = "Standard_B2s"
  }
}

variable "multiple_vms" {
  description = "Multiple VM objects example"

  type = map(object({
    name = string
    size = string
  }))

  default = {
    dev = {
      name = "vm-dev"
      size = "Standard_B2s"
    }

    prod = {
      name = "vm-prod"
      size = "Standard_B4ms"
    }
  }
}

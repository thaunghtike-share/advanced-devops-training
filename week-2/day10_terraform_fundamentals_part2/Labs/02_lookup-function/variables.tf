variable "environment" {
  type    = string
  default = "uat"
}

variable "vm_sizes" {
  type = map(string)

  default = {
    dev  = "Standard_B1s"
    prod = "Standard_D2s_v3"
  }
}

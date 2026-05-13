variable "location" {
  type    = string
  default = "southeastasia"
}

variable "storage_accounts" {
  type = map(string)

  default = {
    dev  = "Standard"
    prod = "Standard"
  }
}

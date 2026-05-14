variable "location" {
  type    = string
  default = "southeastasia"
}

variable "storage_accounts" {
  description = "Storage accounts by environment"
  type        = map(string)

  default = {
    dev  = "Standard"
    prod = "Standard"
  }
}

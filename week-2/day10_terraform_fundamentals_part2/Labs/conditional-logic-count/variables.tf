variable "create_rg" {
  description = "Create resource group or not"
  type        = bool
  default     = true
}

variable "location" {
  type    = string
  default = "southeastasia"
}

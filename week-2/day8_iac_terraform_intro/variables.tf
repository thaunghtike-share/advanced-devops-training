# variables.tf

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "demo-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Southeast Asia"
}

variable "storage_account_name" {
  description = "Storage account name (must be globally unique)"
  type        = string
  default     = "demostorageacct123"
}
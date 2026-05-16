variable "location" {
  description = "Azure region"
  type        = string
  default     = "southeastasia"
}

variable "admin_username" {
  description = "Linux VM admin username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to your SSH private key"
  type        = string
  default     = "~/.ssh/id_rsa"
}

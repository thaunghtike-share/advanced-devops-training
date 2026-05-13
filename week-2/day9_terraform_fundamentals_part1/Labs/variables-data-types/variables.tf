variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "instance_count" {
  description = "Number value example"
  type        = number
  default     = 2
}

variable "enable_logging" {
  description = "Boolean value example"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "southeastasia"
}

variable "location" {
  type    = string
  default = "southeastasia"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    environment = "dev"
    project     = "terraform"
    owner       = "student"
  }
}

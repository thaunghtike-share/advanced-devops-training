variable "vm_names" {
  type    = list(string)
  default = ["app1", "app2", "app1", "app3"]
}

variable "subnets" {
  type = list(list(string))

  default = [
    ["web-1", "web-2"],
    ["app-1"],
    ["db-1", "db-2"]
  ]
}

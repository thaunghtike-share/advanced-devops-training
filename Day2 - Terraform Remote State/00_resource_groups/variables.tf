variable "resource_groups" {
  type = map(object({
    location = string
    tags     = map(string)
  }))
}
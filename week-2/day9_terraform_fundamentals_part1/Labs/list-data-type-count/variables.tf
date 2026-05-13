variable "locations" {
  description = "List of Azure regions"
  type        = list(string)
  default     = ["eastus", "westus", "southeastasia"]
}

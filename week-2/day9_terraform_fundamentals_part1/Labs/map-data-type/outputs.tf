output "all_tags" {
  value = var.tags
}

output "environment_tag" {
  value = var.tags["environment"]
}

output "original_vm_names" {
  value = var.vm_names
}

output "unique_vm_names" {
  value = local.unique_vm_names
}

output "original_subnets" {
  value = var.subnets
}

output "flat_subnets" {
  value = local.flat_subnets
}

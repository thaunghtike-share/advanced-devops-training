output "single_vm_name" {
  value = var.single_vm.name
}

output "single_vm_size" {
  value = var.single_vm.size
}

output "all_vms" {
  value = var.multiple_vms
}

output "prod_vm_size" {
  value = var.multiple_vms["prod"].size
}

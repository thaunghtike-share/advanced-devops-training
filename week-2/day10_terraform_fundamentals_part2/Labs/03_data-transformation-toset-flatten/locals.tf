locals {
  unique_vm_names = toset(var.vm_names)
  flat_subnets    = flatten(var.subnets)
}

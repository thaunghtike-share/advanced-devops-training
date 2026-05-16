locals {
  selected_vm_size = lookup(var.vm_sizes, var.environment, "Standard_B1ls")
}

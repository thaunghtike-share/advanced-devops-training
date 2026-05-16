resource "azurerm_resource_group" "rg" {
  name     = "rg-provisioner-demo"
  location = var.location

  provisioner "local-exec" {
    command = "echo Resource group ${self.name} created > provisioner-output.txt"
  }
}

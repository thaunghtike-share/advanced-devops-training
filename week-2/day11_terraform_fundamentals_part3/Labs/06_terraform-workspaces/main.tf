locals {
  workspace = terraform.workspace
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.workspace}-workspace-demo"
  location = var.location

  tags = {
    Workspace = local.workspace
  }
}

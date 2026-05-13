resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-variables-demo"
  location = var.location

  tags = {
    Environment   = var.environment
    InstanceCount = tostring(var.instance_count)
    Logging       = tostring(var.enable_logging)
  }
}

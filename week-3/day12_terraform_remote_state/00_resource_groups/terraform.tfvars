resource_groups = {
  "my-rg" = {
    location = "West Europe"
    tags = {
      ManagedBy = "Terraform"
      Project   = "Training"
    }
  },
  "tfstate-rg" = {
    location = "West Europe"
    tags = {
      ManagedBy = "Terraform"
      Project   = "Training"
    }
  }
}
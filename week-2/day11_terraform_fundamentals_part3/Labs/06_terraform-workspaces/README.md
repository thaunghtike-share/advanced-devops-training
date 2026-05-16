# Lab 11 — Terraform Workspaces

This lab explains Terraform workspaces using simple Azure Resource Group code.

## Simple idea

Terraform workspace is like a named state inside the same Terraform folder.

Example:

```hcl
terraform.workspace
```

If current workspace is `dev`, the value is:

```text
dev
```

If current workspace is `prod`, the value is:

```text
prod
```

In this lab, the resource group name changes based on the workspace:

```hcl
name = "rg-${terraform.workspace}-workspace-demo"
```

So:

```text
dev  -> rg-dev-workspace-demo
prod -> rg-prod-workspace-demo
```

## Commands

```bash
terraform init
terraform workspace list
terraform workspace new dev
terraform apply
terraform workspace new prod
terraform apply
terraform workspace list
```

## Clean up

Destroy each workspace separately:

```bash
terraform workspace select prod
terraform destroy

terraform workspace select dev
terraform destroy

terraform workspace select default
```

## Important note

Workspaces are good for learning and simple demos.

For real production environments, separate backend/state per environment is usually safer and clearer.

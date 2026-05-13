# Lab 09 — Terraform Workspaces

Use workspaces to create environment-based resource names.

## Commands

```bash
terraform init
terraform workspace list
terraform workspace new dev
terraform apply
terraform workspace new prod
terraform apply
terraform workspace list
terraform destroy
terraform workspace select dev
terraform destroy
terraform workspace select default
```

> Workspaces are useful for learning, but for production isolation, separate backend/state per environment is often safer.

# Terraform Fundamentals Part 1 — Beginner Hands-On Labs

These labs are designed for beginners and match Terraform Fundamentals Part 1 topics.

## Labs

1. Variables vs Data Types
2. List Data Type and Count
3. Map Data Type
4. Object vs map(object)
5. for_each
6. lookup()
7. Variables vs Locals
8. Final Mini Project

## Before Running

```bash
az login
az account show
```

Then open each lab folder and run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
```

## Notes

- Storage account labs use `random_string` to avoid Azure global name conflicts.
- Code is intentionally simple for beginner students.
- Each lab is separated into its own folder.

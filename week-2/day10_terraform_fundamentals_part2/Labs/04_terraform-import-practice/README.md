# Lab 03 — Terraform Import

This lab teaches the Terraform import workflow.

## Important

You must create the Azure resource group first, then write matching Terraform code, then import it.

## Step 1 — Create Resource Group Manually

```bash
az group create \
  --name mahar-rg \
  --location eastus
```

## Step 2 — Check Resource ID

```bash
az group show \
  --name mahar-rg \
  --query id \
  -o tsv
```

## Step 3 — Terraform Commands

```bash
terraform init
terraform import azurerm_resource_group.rg /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/mahar-rg
terraform plan
```

## Step 4 — Clean Up

After import testing:

```bash
terraform destroy
```

Or manually:

```bash
az group delete --name mahar-rg
```

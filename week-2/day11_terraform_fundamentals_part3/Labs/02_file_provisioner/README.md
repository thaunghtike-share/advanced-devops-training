# Lab 07 — Terraform Provisioners: file

This lab creates a small Azure Linux VM, then uses the Terraform `file` provisioner to copy a local file to the VM.

## What it creates

- Resource Group
- VNet and Subnet
- Public IP
- Network Security Group allowing SSH
- Network Interface
- Linux VM
- `file` provisioner copy action

## What the provisioner does

```text
message.txt -> /tmp/message.txt
```

## Before running

Create an SSH key if you do not already have one:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

Copy the example tfvars file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

## Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Verify

Use the output public IP:

```bash
ssh azureuser@<VM_PUBLIC_IP>
cat /tmp/message.txt
```

## Clean up

```bash
terraform destroy
```

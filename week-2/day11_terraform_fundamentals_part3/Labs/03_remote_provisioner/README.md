# Lab 08 — Terraform Provisioners: remote-exec

This lab creates a small Azure Linux VM, then uses the Terraform `remote-exec` provisioner to run commands on the VM.

## What it creates

- Resource Group
- VNet and Subnet
- Public IP
- Network Security Group allowing SSH
- Network Interface
- Linux VM
- `remote-exec` provisioner commands

## What the provisioner does

```bash
echo 'Hello from Terraform remote-exec' > /tmp/remote-exec-demo.txt
hostname
cat /tmp/remote-exec-demo.txt
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
cat /tmp/remote-exec-demo.txt
```

## Clean up

```bash
terraform destroy
```

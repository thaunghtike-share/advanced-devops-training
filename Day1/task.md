### Day 1: Production Architecture & Foundation Setup

**1. Our Infrastructure Design**
Today, we are laying the foundation for the production architecture shown in our diagram. We will set up our core networking and version control structure.

**2. Create 3 Repositories**
*   **Task:** Create three Git repositories: `terraform-azure`, `kubernetes`, and `azure-vault` [1].
*   **Why:** We must separate our concerns. `terraform-azure` is exclusively for provisioning Azure resources, `kubernetes` will hold our ArgoCD Helm charts to use later, and `azure-vault` is strictly for storing secrets [1].

**3. Folder Structure & Remote State**
*   **Task:** Configure a **remote state** data source [1], then initialize your repositories with the following exact modular structures.

📁 **`terraform-azure` Repository Structure:**
We never use a single monolithic file. Modular folders make infrastructure manageable and secure [1].

```text

terraform-azure/
├── 00_resource_groups/
│   ├── rg.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── providers.tf
│   ├── outputs.tf
│   └── README.md
├── 01_networking/
│   ├── vnet.tf
│   ├── nat.tf
│   ├── peering.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── providers.tf
│   ├── outputs.tf
│   └── README.md
├── 02_aks_compute/
│   ├── aks.tf
│   ├── node_pools.tf
│   ├── rbac.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── providers.tf
│   ├── outputs.tf
│   └── README.md
├── 03_k8s_resources/
├── 04_azure_vm/
├── 05_databases/
├── 06_database_backup/
├── 07_redis/
├── 08_rabbitmq/
├── generate-docs.sh
└── README.md

```

(Note: Set up 00_resource_groups and 01_networking today)

📁 kubernetes Repository Structure: This repo will hold our ArgoCD Application manifests and our actual Helm charts

```text

kubernetes/
├── applications/
│   ├── root.yaml
│   ├── app1.yaml
│   ├── app2.yaml
│   ├── app3.yaml
├── helm_charts/
│   ├── app1/
│   ├── app2/
│   └── app3/
└── README.md
```

4. Create RG and 2 VNets (core-vnet & vpn-vnet) via Terraform

 - Task: Write the Terraform code inside your 01_networking folder to provision a Resource Group, core-vnet (with an Azure NAT Gateway), and vpn-vnet
 - Why 2 VNets? This is crucial. core-vnet will manage outbound traffic via the NAT Gateway. Because it has a NAT Gateway, configuring a VPN inside it is very difficult. Therefore, we create a completely separate vpn-vnet dedicated strictly to handling private access for our AKS cluster and Databases

## Topics You Need to Learn Today

you need to research and understand these core concepts to complete today's tasks successfully:

*   **Terraform Remote State:** Learn why we store state files remotely (e.g., Azure Blob Storage) instead of locally, and how a remote state data source enables state locking and secure team collaboration [1].
*   **Modular Infrastructure as Code:** Understand why we separate Terraform configurations into specific folders (like `00_resource_groups` and `01_networking`) instead of writing single monolithic files [2, 3].
*   **Azure Networking & Peering:** Learn how Azure Virtual Networks (VNets) work and how to securely connect two separate VNets using VNet Peering [3, 4].
*   **Egress Control & NAT Gateways:** Study how an Azure NAT Gateway handles outbou
### 🚀 Day 2: Environment Management (Infrastructure vs. Application Layers)

Today, we are looking at exactly how we structure our files to manage Dev, UAT, and Prod environments. Because we are using a **Single Infrastructure Model** (meaning we have only one main AKS cluster), we must strictly separate how we handle the Cloud resources (Terraform) from the K8s resources (GitOps).

---

### 🏗️ 1. The Infrastructure Layer (Terraform)

At the infrastructure level, we are building everything in one primary environment, but we must divide the architecture into **Layers** [1]. This prevents having one massive, dangerous state file. Instead of organizing by environment, we organize by resource type.

**📂 Your Full Terraform File Tree (`terraform-mbr`):**
Here is exactly what you need to create and manage. Notice how each layer has its own `.tf` files and its own isolated state:

```text
terraform-mbr/
├── 00_resource_groups/        # Layer 0: Resource Groups
│   ├── rg.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   └── README.md
│
├── 01_networking/             # Layer 1: Virtual Networks & NAT [2]
│   ├── vnet.tf
│   ├── nat.tf                 # For core-vnet (Outbound traffic) [1]
│   ├── peering.tf             # Connects core-vnet and vpn-vnet [2]
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   └── README.md
│
├── 02_aks_compute/            # Layer 2: Kubernetes Cluster [3]
│   ├── aks.tf
│   ├── node_pools.tf
│   ├── rbac.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   └── README.md
│
├── 03_k8s_resources/          # Future Layers
├── 04_azure_vm/               
├── 05_databases/              
├── 06_database_backup/        
├── 07_redis/                  
├── 08_rabbitmq/               
├── generate-docs.sh           
└── README.md   
```

## Key Takeaways for Infra Layer:

- Layered State: We use terraform_remote_state so 02_aks_compute can fetch the VNet ID securely from 01_networking without combining their state files.
- The 2 VNet Strategy: We deploy core-vnet with a NAT Gateway for outbound API whitelisting, and a separate vpn-vnet to safely handle private access to the AKS cluster and Databases
.

## 🐙 2. The Application Layer (Kubernetes & GitOps)

Because we are deploying to a Single AKS cluster, we manage our Dev, UAT, and Prod environments using Kubernetes Namespaces.

- To do this professionally, we use the ArgoCD ApplicationSet pattern on a single main branch
- We do not create separate Git branches for dev/uat/prod
- One Helm chart rules them all.

📂 Your Full GitOps File Tree (kubernetes repo): Here is exactly how you structure the application deployment configurations:

```text
kubernetes/
│
├── apps.yaml                          # 👈 The ArgoCD ApplicationSet Controller [4]
│
└── helm_charts/
    ├── exchange-backend/
    │   ├── Chart.yaml
    │   ├── templates/                 # 👈 Environment-agnostic K8s YAMLs [5]
    │   │   ├── deployment.yaml
    │   │   ├── service.yaml
    │   │   └── ingress.yaml
    │   ├── values-dev.yaml            # 👈 Injects namespace: dev [4]
    │   ├── values-uat.yaml            # 👈 Injects namespace: uat [6]
    │   └── values-prod.yaml           # 👈 Injects namespace: prod [6]
    │
    ├── exchange-frontend/
    │   ├── Chart.yaml
    │   ├── templates/
    │   ├── values-dev.yaml
    │   ├── values-uat.yaml
    │   └── values-prod.yaml
    │
    └── README.md
```

### Key Takeaways for App Layer:

- Zero Duplication: You never duplicate the deployment.yaml or service.yaml. You write it once in the templates/ folder
- Value Files Dictate Environment: If you want to deploy to UAT, ArgoCD takes the generic template and injects the variables (like replicas or database URLs) specifically from values-uat.yaml
- The Controller Flow: You push an image tag update to main -> The apps.yaml (ApplicationSet) detects it -> It automatically generates the ArgoCD Application and deploys the Helm chart to the correct Kubernetes namespace

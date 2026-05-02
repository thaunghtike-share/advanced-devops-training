# Terraform Modules - Assignment (Part 2)

## 🟩 Assignment 1 — Basic Module Refactoring (Simple)

### 🎯 Goal
Convert existing Terraform folders into reusable child modules and call them from a root module.

---

### 🧱 Target Structure
```
modules/
├── azure_rg/
├── azure_vnet/
└── azure_vm/

live/
└── single_aks_infra/
    ├── 00_rg/
    ├── 01_networking/
    ├── 03_vm/
    ├── providers.tf
    └── terraform.tfvars
```

> NOTE
>
> You can create an additional layer such as 04_azure_sql, and use remote (published) modules for it.

---

### 🔧 Tasks

#### ✅ Task 1 — Move Code into Modules
- Move:
  - 00_resource_groups → modules/azure_rg
  - 01_networking → modules/azure_vnet
  - 03_azure_vm → modules/azure_vm

---

#### ✅ Task 2 — Module Structure
Each module must include:
- main.tf
- variables.tf
- outputs.tf

---

#### ✅ Task 3 — Call Modules per Layer

Each layer folder will call a module:

**live/single_aks_infra/00_rg/main.tf**
```
module "rg" {
  source   = "../../../modules/azure_rg"
  name     = var.rg_name
  location = var.location
}
```

---

**live/single_aks_infra/01_networking/main.tf**
```
module "vnet" {
  source              = "../../../modules/azure_vnet"
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  address_space       = var.address_space
}
```

---

**live/single_aks_infra/03_vm/main.tf**
```
module "vm" {
  source              = "../../../modules/azure_vm"
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  subnet_id           = data.terraform_remote_state.vnet.outputs.subnet_id
}
```

---

#### ✅ Task 4 — Use Remote State Between Layers

Example:
```
data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config = {
    key = "dev-rg.tfstate"
  }
}
```

---

### 🧪 Expected Outcome
- Each layer deploys independently
- Uses remote state to connect layers
- Follows company folder standard

---

## 🟨 Assignment 2 — Multi-Environment (Advanced)

### 🎯 Goal
Support multiple environments (dev, uat, prod) using the same structure

---

### 🧱 Target Structure
```
modules/
├── azure_rg/
├── azure_vnet/
└── azure_vm/

live/
├── dev/
│   ├── 00_rg/
│   ├── 01_networking/
│   └── 03_vm/
├── uat/
│   ├── 00_rg/
│   ├── 01_networking/
│   └── 03_vm/
└── prod/
    ├── 00_rg/
    ├── 01_networking/
    └── 03_vm/
```

---

### 🔥 Tasks

#### ✅ Task 1 — Reuse Same Modules
All environments must use:
- modules/azure_rg
- modules/azure_vnet
- modules/azure_vm

---

#### ✅ Task 2 — Environment Variables

**dev**
```
rg_name = "dev-rg"
environment = "dev"
```

**uat**
```
rg_name = "uat-rg"
environment = "uat"
```

**prod**
```
rg_name = "prod-rg"
environment = "prod"
```

---

#### ✅ Task 3 — Separate Remote State

Each environment must use different state:

- dev → dev-rg.tfstate
- uat → uat-rg.tfstate
- prod → prod-rg.tfstate

---

#### ✅ Task 4 — Naming Convention

```
name = "${var.environment}-rg"
```

---

### 🧠 Learning Outcomes
- Follow company-standard layered structure
- Reuse modules across environments
- Maintain strict separation of state
- Build real-world Terraform architecture

---

### 🧨 Bonus Challenge
How to deploy all environments automatically?

(Hint: CI/CD pipeline or Terraform workspaces)

# 🚀 3-Month DevOps Mentorship Program
**Focus:** Azure, Terraform, Kubernetes (AKS), GitOps (ArgoCD), and Observability.

---

## 📅 Month 1: Advanced Terraform, Key Vault & K8s Internals
**Objective:** Master Infrastructure as Code (IaC) and secure Kubernetes deployments.

### Week 1: # Terraform Mastery Progress Summary

### Day 1: Terraform Fundamentals (Part 1)
* **Concepts:** Core pillars of Infrastructure as Code (IaC). Mastering **Input Data Modeling** using complex types like `map(object({...}))` and using **Locals** to keep the logic "DRY" (Don't Repeat Yourself).
* **Iteration Engine:** Implementing `for_each` to scale resources dynamically and using the `lookup()` function to handle optional data attributes and avoid runtime errors.
* **Key Takeaway:** Understanding that Terraform is not just a script, but a state-driven engine that requires precise data structures to function at scale.

### Day 2: State Management & Remote State
* **Concepts:** Moving from local state to **Enterprise-grade Remote Backends** (Azure Storage Account) to enable team collaboration and **State Locking**.
* **Data Chaining:** Mastering the `terraform_remote_state` data source to fetch information from one layer (e.g., Resource Group IDs) and consume it in another layer (Networking) without hardcoding values.
* **Deep Dive:** Understanding the state lifecycle—how Terraform tracks real-world infrastructure vs. configuration files to maintain the "Source of Truth."

### Day 3: Introduction to Terraform Modules
* **Concepts:** Moving from "Scripting" to "Engineering." Understanding a Module as a **Container** that encapsulates multiple resources into a single logical unit.
* **Module Anatomy:** Establishing the **Standard Module Structure**—the role of `main.tf` (Implementation), `variables.tf` (The Interface), and `outputs.tf` (The Data Contract).
* **Sourcing:** Learning how to call local modules via relative paths and exploring the **Terraform Registry** to consume official, verified infrastructure patterns.

### Day 4: Advanced Modules Lab (The Refactoring Challenge)
* **Hands-on Lab:** Refactoring individual resource folders (`00_rg`, `01_vnet`, `03_vm`) into a library of **Reusable Child Modules**.
* **Output Chaining:** Implementing a "Producer-Consumer" pattern where the Networking module outputs a Subnet ID and the VM module consumes it as a direct input, replacing static data sources.
* **Environmental Scaling:** Implementing a **Root Module** orchestrator to deploy across multiple environments (Dev, UAT, Prod) using the same code base with different parameter values (e.g., SKU sizes and CIDR blocks).

---

### Week 2: # Advanced Terraform Operations & Governance

### Day 5: Conditional Logic & Dynamic Infrastructure
* **Concepts:** Transitioning from static scripts to "Intelligent" configurations.
* **Topic 1: Conditional Resource Provisioning:** * Implementing the Ternary Operator: `count = var.create_vm ? 1 : 0`.
    * **The Lead's Insight:** Understanding why `for_each` is superior to `count` for scaling to prevent "Index Shifting" during resource updates.
* **Topic 2: Dynamic Blocks:** * Mastering the `dynamic` block syntax to iterate over nested configurations (e.g., generating multiple `security_rule` blocks within a single NSG resource).
* **Topic 3: Input Validation:** * Using `validation` blocks within variables to enforce SKU constraints and naming conventions, preventing "illegal" infrastructure from being planned.

### Day 6: Provisioners & Environment Isolation
* **Concepts:** Handling the "Last Mile" of configuration and managing multiple environments.
* **Topic 1: Terraform Provisioners:** * **local-exec:** Running scripts on the local machine (e.g., updating local SSH config).
    * **remote-exec & file:** Bootstrapping VMs by moving scripts and executing commands (e.g., installing Nginx/Docker) post-creation.
* **Topic 2: Terraform Workspaces:** * Mastering state isolation using `terraform workspace new`, `list`, and `select`.
    * Using `${terraform.workspace}` to dynamically name resources based on the active environment.
* **Topic 3: Architectural Debate:** * Comparing **Workspaces** (shared state file) vs. **Directory-based Layouts** (fully isolated states) and when to use each in an Enterprise setting.

### Day 7: State Refactoring, Security & CI/CD
* **Concepts:** Production-grade safety, secret management, and automation.
* **Topic 1: Zero-Downtime Refactoring:** * Implementing the **`moved` block** to rename resources or migrate them into modules without a "Destroy and Recreate" event.
    * **State CLI:** Using `terraform state rm` and `terraform import` to bring existing manual resources under IaC management.
* **Topic 2: Security & Lifecycle Hooks:** * **Secrets Management:** Integrating with **Azure Key Vault** data sources to pull credentials at runtime and using `sensitive = true`.
    * **Lifecycle Management:** Using `prevent_destroy` to protect production databases and `create_before_destroy` for zero-downtime blue/green updates.
* **Topic 3: The DevOps Pipeline:** * Orchestrating Terraform in **GitHub Actions** or **Azure DevOps**—automating `plan` on Pull Requests and `apply` on Merges to the `main` branch.

---

### **Assignment 3: The Smart Infrastructure (Day 5 & 6 Lab)**

**Objective:** Build a self-configuring, environment-aware infrastructure.

**The Task:**
1. **Dynamic Security:** Use a `dynamic` block to deploy an NSG that opens a list of 5 ports (80, 443, 22, etc.) based on a single map variable.
2. **Post-Build Scripting:** Use a **Provisioner** (`remote-exec`) to install a Web Server (Nginx/Apache) automatically once the VM is created.
3. **Workspace Logic:** Use **Workspaces** to create `dev` and `prod`. Use a **Conditional** (`count`) to ensure a "Bastion Host" is ONLY created when the workspace is `prod`.

### **Assignment 4: The Secure Refactor (Day 7 Lab)**

**Objective:** Clean up existing "messy" code and secure sensitive data.

**The Task:**
1. **The Refactor:** Take a resource you previously created in the Root module and move it into a Child Module using a **`moved` block**. Prove that `terraform plan` shows 0 resources to be destroyed.
2. **Zero-Secret Policy:** Remove all plain-text passwords from `terraform.tfvars`. Fetch the VM Administrator password from **Azure Key Vault** using a Data Source.
3. **The Safety Catch:** Add a `lifecycle { prevent_destroy = true }` block to your Resource Group and try to run `terraform destroy`. Document the result.

---

**Summary & Graduation Wrap-up**
> "By the end of Day 7, you are no longer just writing code. You are managing **State**, enforcing **Security**, and automating **Delivery**. You are ready for a Production environment."
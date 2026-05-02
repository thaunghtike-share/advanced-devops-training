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

### Week 2: K8s Cluster Management & Lens IDE
* **Day 4: Real-World K8s Management**
    * **1-Hour Session:** Guide on how Senior Engineers interact with clusters.
    * **Offline Assignment:** Install Lens IDE. Connect to AKS and explore namespaces, core components, and nodes.
* **Day 5: K8s RBAC & Identities**
    * **1-Hour Session:** Explain Azure Managed Identities and K8s RBAC.
    * **Offline Assignment:** Write Terraform code to assign Roles so the AKS cluster can securely communicate with Azure Key Vault.
* **Day 6: Month 1 Infrastructure Review**
    * **1-Hour Session:** Strict code review of all Terraform modules.
    * **Offline Assignment:** Resolve mentor comments, destroy infrastructure, and re-apply to prove **idempotency**.

### Week 3: Helm Processing & Vault Injection
* **Day 7: Helm Charts Architecture**
    * **1-Hour Session:** Critique raw YAML vs. Helm. Explain Helm templating.
    * **Offline Assignment:** Convert application Kubernetes YAML files into a structured Helm Chart.
* **Day 8: Fetching Secrets from Vault**
    * **1-Hour Session:** Explain Azure Key Vault Provider for Secrets Store CSI Driver.
    * **Offline Assignment:** Configure Helm chart to fetch DB credentials from Key Vault and mount them as environment variables.
* **Day 9: Secrets Validation**
    * **1-Hour Session:** Verify the secret injection flow.
    * **Offline Assignment:** Use Lens to `exec` into the pod and prove the application successfully connected to the DB using Vault secrets.

### Week 4: Database Routing & Month 1 Wrap-up
* **Day 10: Dev/UAT DB on K8s**
    * **1-Hour Session:** Discuss cost-saving for non-prod environments.
    * **Offline Assignment:** Deploy a Dev/UAT database directly on AKS using **StatefulSets**.
* **Day 11: Application Routing**
    * **1-Hour Session:** Explain environment-specific configurations.
    * **Offline Assignment:** Configure Helm to support routing to in-cluster Dev DB vs. Azure Managed Prod DB based on values.
* **Day 12: K8s & Terraform Evaluation**
    * **1-Hour Session:** Final review of Month 1 setup to ensure readiness for GitOps.

---

## 📅 Month 2: Continuous Deployment & Advanced GitOps (ArgoCD)
**Objective:** Fully automate the deployment lifecycle using the GitOps philosophy.

### Week 5: Manifest Automation & ArgoCD Setup
* **Day 13: The Manifest Repository**
    * **1-Hour Session:** Explain separation of App Code vs. Manifest Repo.
    * **Offline Assignment:** Set up a dedicated K8s Manifest Repo. Write a GitHub Action to update image tags.
* **Day 14: ArgoCD Operator Deployment**
    * **1-Hour Session:** Explain GitOps principles and ArgoCD architecture.
    * **Offline Assignment:** Install ArgoCD Operator on AKS and local CLI. Connect ArgoCD to the Manifest Repo.
* **Day 15: ArgoCD UI & Application Creation**
    * **1-Hour Session:** Guide through the ArgoCD UI.
    * **Offline Assignment:** Deploy the first application via ArgoCD UI and observe the initial sync.

### Week 6: Advanced ArgoCD Patterns
* **Day 16: Parent/Child App Sync Pattern**
    * **1-Hour Session:** Discuss enterprise multi-app deployments.
    * **Offline Assignment:** Implement "App of Apps" pattern (Root app detecting changes for child microservices).
* **Day 17: Desired State Reconciliation**
    * **1-Hour Session:** Live test of ArgoCD drift detection.
    * **Offline Assignment:** Manually delete a deployment via Lens; document how ArgoCD automatically restores the state.
* **Day 18: Health Validation**
    * **1-Hour Session:** Explain how ArgoCD determines app health.
    * **Offline Assignment:** Intentionally break a readiness probe and observe Health Validation failure.

### Week 7 & 8: GitOps Deep Dive & Flow Mastery
* **Day 19: Managing Helm via ArgoCD**
    * **1-Hour Session:** Explain dynamic Helm value processing in ArgoCD.
    * **Offline Assignment:** Pass environment-specific values (Dev vs. Prod) during sync.
* **Day 20: ArgoCD Sync Waves & Hooks**
    * **1-Hour Session:** Discuss deployment ordering.
    * **Offline Assignment:** Implement Sync Waves to ensure DB initializes before the App starts.
* **Day 21-24: End-to-End Troubleshooting**
    * **1-Hour Sessions:** Mentor intentionally breaks sync or Vault policies.
    * **Offline Assignments:** Troubleshoot, fix, and ensure the pipeline is production-ready.

---

## 📅 Month 3: Observability Stack & Incident Management
**Objective:** Build robust logging/monitoring and interview confidence.

### Week 9: Log Aggregation (Loki Stack)
* **Day 25: Deploying Loki Alloy**
    * **1-Hour Session:** Observability concepts and unified agents.
    * **Offline Assignment:** Deploy Loki Alloy on AKS to scrape metrics and logs.
* **Day 26: Deploying Loki**
    * **1-Hour Session:** Log stream storage architecture.
    * **Offline Assignment:** Deploy Loki to aggregate streams forwarded by Alloy.
* **Day 27: Log Querying via Grafana**
    * **1-Hour Session:** Explain LogQL.
    * **Offline Assignment:** Build a Grafana dashboard querying application logs.

### Week 10: Monitoring, Metrics & Webhooks
* **Day 28: Prometheus Integration**
    * **1-Hour Session:** Time-series metrics.
    * **Offline Assignment:** Deploy Prometheus via Alloy. Build Grafana dashboards for CPU/Memory.
* **Day 29: Alertmanager Configuration**
    * **1-Hour Session:** Incident response and routing.
    * **Offline Assignment:** Configure Alertmanager for `HighCPU` or `CrashLoopBackOff` alerts.
* **Day 30: Google Chat Webhook Integration**
    * **1-Hour Session:** Webhook mechanics.
    * **Offline Assignment:** Connect Alertmanager to Google Chat. Test by spiking CPU.

### Week 11: Real-World Chaos Engineering
* **Day 31: Scenario 1 - Key Vault Outage**
    * **1-Hour Session:** Revoke AKS access to Key Vault.
    * **Offline Assignment:** Use logs/ArgoCD to find the cause, fix RBAC, and write an RCA.
* **Day 32: Scenario 2 - CrashLoop & Alerting**
    * **1-Hour Session:** Deploy a broken image tag.
    * **Offline Assignment:** Acknowledge alert, trace logs, rollback in ArgoCD, and document.
* **Day 33: Operations Post-Mortem**
    * **1-Hour Session:** Mock CTO review of incident response and production communication.

### Week 12: Interview Prep & Professional Polish
* **Day 34: System Design Interview Prep**
    * **1-Hour Session:** Whiteboard techniques for the full architecture.
    * **Offline Assignment:** Practice explaining the end-to-end flow.
* **Day 35: Mock Technical Interview**
    * **1-Hour Session:** Q&A on State locks, GitOps reconciliation, and CSI drivers.
* **Day 36: Final Handoff & Career Strategy**
    * **1-Hour Session:** Final review and actionable steps for the Ireland job market.
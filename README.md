# 🚀 3-Month DevOps Mentorship Program
**Focus:** Azure, Terraform, Kubernetes (AKS), GitOps (ArgoCD), and Observability.

---

## 📅 Month 1: Advanced Terraform & Kubernetes Foundation
**Objective:** Master Infrastructure as Code (IaC) and the core architecture of Kubernetes.

### Week 1: Terraform Mastery Progress Summary
* **Day 1: Terraform Fundamentals - Part 1**
    * **Concepts:** Core pillars of IaC. Mastering Input Data Modeling using complex types like `map(object({...}))` and using **Locals** to keep the logic "DRY".
    * **Iteration Engine:** Implementing `for_each` to scale resources and using `lookup()` to handle optional data attributes.
* **Day 2: Terraform Fundamentals - Part 2**
    * **Topic 1: Conditional Infrastructure:** Mastering the Ternary Operator (`count`) and the Lead's insight on `for_each` vs `count` for index shifting.
    * **Topic 2: Terraform Import:** Mastering the `terraform import` command to bring "Brownfield" resources into HCL.
    * **Topic 3: Dynamic Blocks:** Implementing nested iteration for complex configurations like NSG rules.
    * **Topic 4: Provisioners & Isolation:** Deep dive into `local-exec`, `remote-exec`, and `file`. Managing environment isolation via Terraform Workspaces.
* **Day 3: State Management & Remote State**
    * **Concepts:** Moving to **Enterprise-grade Remote Backends** (Azure Storage) and State Locking.
    * **Data Chaining:** Mastering the `terraform_remote_state` data source to fetch information between layers without hardcoding.
* **Day 4: Introduction to Terraform Modules**
    * **Concepts:** Moving from "Scripting" to "Engineering." Understanding Modules as Containers.
    * **Anatomy:** Establishing the Standard Module Structure (`main.tf`, `variables.tf`, `outputs.tf`).

### Week 2: Advanced Terraform Engineering & Enterprise Operations
* **Day 5: Advanced Modules Lab (The Refactoring Challenge)**
    * **Hands-on:** Refactoring individual folders into a library of Reusable Child Modules.
    * **Output Chaining:** Implementing "Producer-Consumer" patterns and Environmental Scaling for Dev, UAT, and Prod.
* **Day 6: Post-Apply Operations & CI/CD Pipelines**
    * **Topic 1: Post-Apply Operations:** Cloud-Init mastery and `cloudinit_config` data source for native bootstrapping without SSH.
    * **Topic 2: Azure OIDC Integration:** Setting up OpenID Connect between GitHub and Azure for passwordless, secure authentication.
    * **Topic 3: The CI/CD Workflow:** Automating `plan` on PR and `apply` on Merge. Handling state management and locking in a concurrent CI environment.
* **Day 7: Enterprise Scaling with Terraform Cloud**
    * **Topic 1: TFC Fundamentals:** Organizations, Workspaces, and shifting from local to Remote Execution.
    * **Topic 2: Governance & Collaboration:** VCS Integration, state versioning history, and Private Module Registries.
    * **Topic 3: Policy as Code:** Introduction to Sentinel/OPA to enforce compliance before deployment.

### Week 3: Kubernetes Architecture
* **Day 8: Kubernetes Summary Part - 1**
    * **Architecture Deep Dive:** Control Plane vs. Worker Nodes. Understanding the roles of `kube-apiserver`, `etcd`, `scheduler`, and `controller-manager`.
     **The Data Plane:** Deep dive into Kubelet, Kube-proxy, and Container Runtime. Understanding the lifecycle of a Pod.
* **Day 9: Kubernetes Summary Part - 2**
    * **Resource Types:** Deep dive into Kubernetes YAML for `Deployment`, `StatefulSet` (STS), `ReplicaSet`, and `DaemonSet`.
    * **Configuration & Storage:** Managing `ConfigMaps` (CM), `Secrets`, and `PersistentVolumeClaims` (PVC).
    * **Scaling & Reliability:** Implementing `Horizontal Pod Autoscaler` (HPA) and `Pod Disruption Budgets` (PDB).
* **Day 10: AKS Details and Node Pools Design**
    * **Production Design:** Designing System vs. User Node Pools. Sizing, Auto-scaling logic, and choosing the right VM SKUs for different workloads.

### Week 4: Managed Kubernetes & Security
* **Day 11: Create AKS and Node Pools using Terraform**
    * **IaC for K8s:** Automating the deployment of AKS with multiple node pools, CNI networking, and identity-based access.
* **Day 12: AKS Security, AKS RBAC and Azure Managed Identities**
    * **Security Hardening:** Implementing Azure RBAC vs Kubernetes RBAC. Mapping Azure Managed Identities to K8s Workload Identities.
* **Day 13: Real-World K8s Management**
    * **Lens IDE:** Installing and connecting Lens. Exploring namespaces, core components, and identifying bottlenecked nodes.

---

## 📅 Month 2: GitOps, Ingress & Database Orchestration
**Objective:** Automate application delivery and manage cluster ingress/secrets.

### Week 5: Essential Components & CI Integration
* **Day 14: Install Essentials Components on AKS**
    * **Orchestration:** Using Terraform to bootstrap ArgoCD, Ingress Controllers, and Cert-Managers for a production-ready cluster.
* **Day 15: Design Dev, UAT Database on AKS**
    * **Stateful Workloads:** Using dedicated node pools for DBs on K8s. Discussing the trade-offs between in-cluster DBs and Managed Azure SQL/PostgreSQL.
* **Day 16: Deploy Image via CI and Docker Best Practices**
    * **CI/CD Bridge:** Automating image builds in GitHub Actions. Implementing Docker best practices (Multi-stage builds, Distroless, and Image Scanning).

### Week 6: Application Packaging & Routing
* **Day 17: Helm Charts Architecture**
    * **Packaging:** Mastering Chart structure, `values.yaml`, and templating logic to make applications reusable.
* **Day 18: Explore Kustomize**
    * **Overlays:** Understanding the difference between Helm (Templating) and Kustomize (Patching). Managing environment-specific overlays.
* **Day 19: Installing Ingress Controller**
    * **Traffic Routing:** Configuring Nginx Ingress and integrating it with Cloudflare DNS for external access.

### Week 7: Security & GitOps Introduction
* **Day 20: Configure Cert Managers**
    * **TLS Automation:** Setting up Let's Encrypt and Cert-Manager to automate SSL/TLS certificate issuance and renewal.
* **Day 21: Creating VPN to access private services**
    * **Private Access:** Securing ArgoCD, Databases, and Grafana via a VPN/Private Link to ensure zero public exposure.
* **Day 22: GitOps Introduction**
    * **The Strategy:** Comparing FluxCD vs. ArgoCD. Understanding the "Push" vs. "Pull" models of Continuous Delivery.

### Week 8: ArgoCD Mastery & Repo Design
* **Day 23: Installing ArgoCD on AKS**
    * **Ops Setup:** Using Terraform for ArgoCD setup, CLI management, User RBAC, and Repository integrations.
* **Day 24: Designing GitOps repository**
    * **Architecture:** Designing the "App of Apps" pattern vs. Standard GitOps. Branching strategies for multi-env management.
* **Day 25: Creating App via multi-env**
    * **Full Automation:** End-to-end flow from GitHub $\rightarrow$ ACR $\rightarrow$ ArgoCD $\rightarrow$ AKS for Dev, UAT, and Prod.

---

## 📅 Month 3: Secrets Management & Observability
**Objective:** Secure the stack and implement full-stack monitoring/alerting.

### Week 9: Continuous Delivery Operations
* **Day 26: ArgoCD Rollback Features**
    * **Recovery:** Mastering rapid rollbacks and understanding why GitOps is the ultimate disaster recovery tool in production.
* **Day 27: Auto update image to deployment**
    * **Automation Ways:** Comparing ArgoCD Image Updater (Pull-based) vs. GitHub Action updates (Push-based).
* **Day 28: Configure ArgoCD Image Updater or GitHub Auto Deploy**
    * **Implementation:** Hands-on lab to automate the full image tag update lifecycle.

### Week 10: Advanced Secret Management
* **Day 29: .env secrets management via GitHub Actions**
    * **CI Secrets:** Managing build-time environment variables and secrets securely within the CI runner.
* **Day 30: .env secrets management via Azure Key Vault**
    * **Vault Governance:** Using Terraform to manage Key Vault policies and injecting secrets into GitHub Actions.
* **Day 31: Auto mount to AKS pods**
    * **CSI Driver:** Using Secret Store CSI Provider Class and Reloader to automatically update Pod env-vars when Vault secrets change.

### Week 11: The Observability Stack
* **Day 32: Observability: Prometheus and Grafana**
    * **Metrics:** Deploying the Prometheus stack. Building custom Grafana dashboards for cluster health and application performance.
* **Day 33: What is Loki? What is Loki Alloy?**
    * **Logs:** Understanding Loki's log aggregation architecture and the role of Loki Alloy as the unified collector.
* **Day 34: Configure Loki Alloy, Loki and Grafana**
    * **Log Pipeline:** Implementing a full log aggregation pipeline from AKS nodes to Grafana.

### Week 12: Incident Response & Alerting
* **Day 35: Alert Manager and Incident Response**
    * **Alerting Logic:** Configuring Alertmanager to route critical cluster failures to the right teams.
* **Day 36: Webhook explanation (Slack / Workspace)**
    * **Notifications:** Connecting monitoring alerts to Slack, Discord, or Teams via Webhooks.
* **Day 37: Lab - configure alert rules**
    * **Chaos Simulation:** Testing alert rules by deploying dummy pods that simulate high CPU or CrashLoopBackOff.

---

### 🎁 Bonus Content: Service Mesh
* **Day 38: Service Mesh Introduction**
    * **Traffic Mgmt:** Why we need a mesh for Microservices. Introduction to mTLS and Observability.
* **Day 39: What is Istio?**
    * **Deep Dive:** Istio features: Traffic splitting (Canary/Blue-Green), Security, and Policy enforcement.
* **Day 40: Explore Kiali**
    * **Visualization:** Using Kiali to map service traffic and identify latency between microservices.
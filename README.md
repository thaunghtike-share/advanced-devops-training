# 🚀 3-Month DevOps Mentorship Program
**Focus:** Azure, Terraform, Kubernetes (AKS), GitOps (ArgoCD), and Observability.

---

## 📅 Month 1: Advanced Terraform, Key Vault & K8s Internals
**Objective:** Master Infrastructure as Code (IaC) and secure Kubernetes deployments.

### Week 1: Terraform Modules & AKS Provisioning
* **Day 1: Terraform Structure & terraform-docs**
    * **1-Hour Session:** Explain enterprise-grade Terraform project structures and state management.
    * **Offline Assignment:** Write Terraform code using reusable modules to provision Azure Kubernetes Service (AKS). Use `terraform-docs` to auto-generate documentation.
* **Day 2: Provisioning Azure Managed Databases**
    * Explain the working environments at both the application and infrastructure levels, and incorporate Terraform-docs.
    * **1-Hour Session:** Review Terraform code and discuss azure vm ubuntu server provisioning. 
    * **Offline Assignment:** Provision Azure Managed Database using Terraform. Configure remote state backend with state locking.
* **Day 3: Terraform Block and Import**
    * **1-Hour Session:** 
    * **Offline Assignment:** 
* **Day 4: Azure Key Vault Integration**
    * **1-Hour Session:** Explain enterprise secrets management.
    * **Offline Assignment:** Provision Azure Key Vault via Terraform. Write a script to auto-generate and store database credentials securely in the Vault.

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
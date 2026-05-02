## Kubernetes, Secret Management & Terraform Lab
**Objective:** Bridge the gap between Infrastructure as Code and K8s Orchestration.

### K8s Cluster Management & Lens IDE
* **Real-World K8s Management**
    * **1-Hour Session:** Guide on how Senior Engineers interact with clusters.
    * **Offline Assignment:** Install Lens IDE. Connect to AKS and explore namespaces, core components, and nodes.
* **K8s RBAC & Identities**
    * **1-Hour Session:** Explain Azure Managed Identities and K8s RBAC.
    * **Offline Assignment:** Write Terraform code to assign Roles so the AKS cluster can securely communicate with Azure Key Vault.
* **Month 1 Infrastructure Review**
    * **1-Hour Session:** Strict code review of all Terraform modules.
    * **Offline Assignment:** Resolve mentor comments, destroy infrastructure, and re-apply to prove **idempotency**.

### Helm Processing & Vault Injection
* **Helm Charts Architecture**
    * **1-Hour Session:** Critique raw YAML vs. Helm. Explain Helm templating.
    * **Offline Assignment:** Convert application Kubernetes YAML files into a structured Helm Chart.
* **Fetching Secrets from Vault**
    * **1-Hour Session:** Explain Azure Key Vault Provider for Secrets Store CSI Driver.
    * **Offline Assignment:** Configure Helm chart to fetch DB credentials from Key Vault and mount them as environment variables.
* **Secrets Validation**
    * **1-Hour Session:** Verify the secret injection flow.
    * **Offline Assignment:** Use Lens to `exec` into the pod and prove the application successfully connected to the DB using Vault secrets.

### Database Routing & Month 1 Wrap-up
* **Dev/UAT DB on K8s**
    * **1-Hour Session:** Discuss cost-saving for non-prod environments.
    * **Offline Assignment:** Deploy a Dev/UAT database directly on AKS using **StatefulSets**.
* **Application Routing**
    * **1-Hour Session:** Explain environment-specific configurations.
    * **Offline Assignment:** Configure Helm to support routing to in-cluster Dev DB vs. Azure Managed Prod DB based on values.
* **K8s & Terraform Evaluation**
    * **1-Hour Session:** Final review of Month 1 setup to ensure readiness for GitOps.

---

## Continuous Deployment & Advanced GitOps (ArgoCD)
**Objective:** Fully automate the deployment lifecycle using the GitOps philosophy.

### Manifest Automation & ArgoCD Setup
* **The Manifest Repository**
    * **1-Hour Session:** Explain separation of App Code vs. Manifest Repo.
    * **Offline Assignment:** Set up a dedicated K8s Manifest Repo. Write a GitHub Action to update image tags.
* **ArgoCD Operator Deployment**
    * **1-Hour Session:** Explain GitOps principles and ArgoCD architecture.
    * **Offline Assignment:** Install ArgoCD Operator on AKS and local CLI. Connect ArgoCD to the Manifest Repo.
* **ArgoCD UI & Application Creation**
    * **1-Hour Session:** Guide through the ArgoCD UI.
    * **Offline Assignment:** Deploy the first application via ArgoCD UI and observe the initial sync.

### Advanced ArgoCD Patterns
* **Parent/Child App Sync Pattern**
    * **1-Hour Session:** Discuss enterprise multi-app deployments.
    * **Offline Assignment:** Implement "App of Apps" pattern (Root app detecting changes for child microservices).
* **Desired State Reconciliation**
    * **1-Hour Session:** Live test of ArgoCD drift detection.
    * **Offline Assignment:** Manually delete a deployment via Lens; document how ArgoCD automatically restores the state.
* **Health Validation**
    * **1-Hour Session:** Explain how ArgoCD determines app health.
    * **Offline Assignment:** Intentionally break a readiness probe and observe Health Validation failure.

### GitOps Deep Dive & Flow Mastery
* **Managing Helm via ArgoCD**
    * **1-Hour Session:** Explain dynamic Helm value processing in ArgoCD.
    * **Offline Assignment:** Pass environment-specific values (Dev vs. Prod) during sync.
* **ArgoCD Sync Waves & Hooks**
    * **1-Hour Session:** Discuss deployment ordering.
    * **Offline Assignment:** Implement Sync Waves to ensure DB initializes before the App starts.
* **End-to-End Troubleshooting**
    * **1-Hour Sessions:** Mentor intentionally breaks sync or Vault policies.
    * **Offline Assignments:** Troubleshoot, fix, and ensure the pipeline is production-ready.

---

## Observability Stack & Incident Management
**Objective:** Build robust logging/monitoring and interview confidence.

### Log Aggregation (Loki Stack)
* **Deploying Loki Alloy**
    * **1-Hour Session:** Observability concepts and unified agents.
    * **Offline Assignment:** Deploy Loki Alloy on AKS to scrape metrics and logs.
* **Deploying Loki**
    * **1-Hour Session:** Log stream storage architecture.
    * **Offline Assignment:** Deploy Loki to aggregate streams forwarded by Alloy.
* **Log Querying via Grafana**
    * **1-Hour Session:** Explain LogQL.
    * **Offline Assignment:** Build a Grafana dashboard querying application logs.

### Monitoring, Metrics & Webhooks
* **Prometheus Integration**
    * **1-Hour Session:** Time-series metrics.
    * **Offline Assignment:** Deploy Prometheus via Alloy. Build Grafana dashboards for CPU/Memory.
* **Alertmanager Configuration**
    * **1-Hour Session:** Incident response and routing.
    * **Offline Assignment:** Configure Alertmanager for `HighCPU` or `CrashLoopBackOff` alerts.
* **Google Chat Webhook Integration**
    * **1-Hour Session:** Webhook mechanics.
    * **Offline Assignment:** Connect Alertmanager to Google Chat. Test by spiking CPU.

### Real-World Chaos Engineering
* **Scenario 1 - Key Vault Outage**
    * **1-Hour Session:** Revoke AKS access to Key Vault.
    * **Offline Assignment:** Use logs/ArgoCD to find the cause, fix RBAC, and write an RCA.
* **Scenario 2 - CrashLoop & Alerting**
    * **1-Hour Session:** Deploy a broken image tag.
    * **Offline Assignment:** Acknowledge alert, trace logs, rollback in ArgoCD, and document.
* **Operations Post-Mortem**
    * **1-Hour Session:** Mock CTO review of incident response and production communication.

### Interview Prep & Professional Polish
* **System Design Interview Prep**
    * **1-Hour Session:** Whiteboard techniques for the full architecture.
    * **Offline Assignment:** Practice explaining the end-to-end flow.
* **Mock Technical Interview**
    * **1-Hour Session:** Q&A on State locks, GitOps reconciliation, and CSI drivers.
* **Final Handoff & Career Strategy**
    * **1-Hour Session:** Final review and actionable steps for the Ireland job market.
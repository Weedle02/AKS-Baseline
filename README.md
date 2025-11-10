# AKS Baseline Platform & Blue/Green Delivery (GitHub Actions)

This repo provisions and operates an **AKS** baseline with **ACR**, **Managed Identity**, **NGINX Ingress**, **CSI Secret Store (Key Vault)**, **HPA/PDBs**, and implements **blue/green** deployments using **GitHub Actions** and **Environments** (approvals). Observability via **Azure Monitor for containers** and **KQL**.

## Prereqs
- Azure subscription + permissions
- ACR name: `{{PLACEHOLDER_ACR}}`
- OIDC Federated Credentials for GitHub → Azure (Client ID/Tenant/Subscription)
- GitHub Environments: `Staging`, `Production` with required reviewers

## Structure
- `infra/terraform` — AKS, ACR, Key Vault, Log Analytics
- `platform/` — Ingress NGINX values, CSI Secret Store
- `apps/sample-web` — Helm chart + blue/green values
- `observability/kql` — dashboards/queries
- `runbooks/` — cutover & rollback

## Workflows
1. `infra-plan-apply.yml` — plan/apply infra to Staging → approve → Prod
2. `build-and-push-image.yml` — build Docker, push to ACR
3. `deploy-blue-green.yml` — deploy green, smoke test, approve cutover

## Quickstart
```bash
# Terraform init/apply (staging)
cd infra/terraform/envs/stg
terraform init
terraform apply

# Get AKS credentials (local check)
az aks get-credentials -n {{PLACEHOLDER_AKS_NAME}} -g {{PLACEHOLDER_AKS_RG}} --overwrite-existing

# Install ingress-nginx and secrets store objects
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -f platform/ingress-nginx/values.yaml
kubectl apply -f platform/csi-secrets-store/
```

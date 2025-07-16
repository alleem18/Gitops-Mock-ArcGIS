# 🌐 GitOps-Mock-ArcGIS: End-to-End Kubernetes GitOps Deployment

> A realistic, production-style simulation of **ArcGIS Enterprise** deployment using **GitOps principles**, inspired by [Esri's ArcGIS GitOps tooling](https://github.com/Esri/arcgis-gitops). This repo demonstrates a modular and declarative infrastructure setup using **Terraform**, **AWS**, **Helm**, and **Prometheus/Grafana** observability.

---

## 📌 Table of Contents

- [🎯 Motivation](#-motivation)
- [📦 Esri GitOps Deployment Inspiration](#-esri-gitops-deployment-inspiration)
- [🧭 Project Structure & Workflow](#-project-structure--workflow)
- [🛠️ Deploy It Yourself (DIY)](#️-deploy-it-yourself-diy)
  - [🔐 Prerequisites](#-prerequisites)
  - [🚀 Step-by-Step Workflow](#-step-by-step-workflow)
- [📊 Monitoring & Observability](#-monitoring--observability)
- [✅ Conclusion](#-conclusion)

---

## 🎯 Motivation

The goal of this project is to simulate how **ArcGIS Server** and **Portal for ArcGIS** components could be deployed in a GitOps-style workflow using open-source tools and cloud-native infrastructure.

Inspired by Esri's internal practices, this mock deployment:
- Automates the full lifecycle: **Provision → Deploy → Monitor**
- Enables testing and rollback using **Helm**
- Integrates **Prometheus and Grafana** for real-time metrics
- Follows a CI/CD pipeline using **GitHub Actions**

---

## 📦 Esri GitOps Deployment Inspiration

Esri maintains several deployment tools for ArcGIS Enterprise across:
- **PowerShell DSC** (for Windows)
- **Chef** (for Linux)
- **Helm Charts** (for Kubernetes)
- **GitHub Actions** for CI/CD pipelines

This repo focuses on the **Kubernetes + Helm** path and re-implements it using:
- A simplified **arcgis-server** (Redis-based) and **arcgis-portal** (Nginx-based)
- Kubernetes-native Helm tests for validation
- Metrics scraping via sidecar exporters
- GitHub Actions that mimic Esri’s pipeline flow

---

## 🧭 Project Structure & Workflow

```bash
Gitops-Mock-ArcGIS/
│
├── .github/workflows/             # CI/CD GitHub Actions for Terraform + Helm
│   ├── terraform-apply.yaml
│   ├── helm-deploy.yaml
│   └── full-deploy.yaml           # Combined GitOps workflow
│
├── terraform/                     # AWS Infrastructure (EKS, IAM, S3, VPC)
│   ├── main.tf
│   └── variables.tf
│
├── helm/                          # Helm charts for arcgis-server & arcgis-portal
│   ├── arcgis-server/
│   └── arcgis-portal/
│
├── monitoring/                    # Prometheus ServiceMonitors and dashboards
│   ├── servicemonitor-server.yaml
│   ├── servicemonitor-portal.yaml
│   └── grafana-dashboards/
│
└── README.md                      # This documentation


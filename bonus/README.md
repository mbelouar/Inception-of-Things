# 🎁 Bonus: CI/CD with GitLab Runner and ArgoCD

This bonus part extends the project by implementing a complete GitOps CI/CD pipeline using GitLab Runner and ArgoCD, demonstrating real-world CI/CD practices for Kubernetes applications.

</div>

## 🎯 Overview

This bonus part implements a complete CI/CD pipeline by combining:

- **GitLab** for source code management and CI (Continuous Integration)
- **GitLab Runner** for executing CI pipelines within Kubernetes
- **ArgoCD** for CD (Continuous Delivery) following GitOps principles

The complete workflow enables automated testing, building, and deployment of applications directly from Git repositories to Kubernetes clusters.

## 🔗 GitLab Project

The GitLab project for this implementation is available at:
[https://gitlab.com/simobelouarraq5/Inception-Of-Things](https://gitlab.com/simobelouarraq5/Inception-Of-Things)

## 🚀 Getting Started

### Prerequisites

- ✅ macOS operating system
- ✅ [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- ✅ [Homebrew](https://brew.sh/) (script will install if missing)

### 🔧 Installation

1. Clone this repository and navigate to the bonus directory:

   ```bash
   git clone https://github.com/yourusername/Inception-of-Things.git
   cd Inception-of-Things/bonus
   ```

2. Set up the environment:

   ```bash
   make setup
   ```

   > ℹ️ This will:
   >
   > - Install required dependencies (kubectl, k3d, argocd, helm)
   > - Create a local K3D cluster
   > - Set up required namespaces
   > - Install ArgoCD
   > - Install and configure GitLab Runner

### 🔍 Checking Runner Status

To check if the GitLab Runner is properly registered and running:

```bash
make runner-status
```

## 🔄 How It Works

### Components

1. **K3D Kubernetes Cluster**: Lightweight Kubernetes cluster running in Docker containers
2. **ArgoCD**: Declarative continuous delivery tool following GitOps principles
3. **GitLab Runner**: Executes CI/CD pipelines defined in your GitLab repository

### CI/CD Workflow

```
GitLab Repo → GitLab CI Pipeline → GitLab Runner → Updates Manifest Files → ArgoCD → K3D Cluster → Application
```

1. **CI Pipeline (GitLab Runner)**:

   - Triggered by commits to the GitLab repository
   - Executes the `.gitlab-ci.yml` pipeline definition
   - Updates manifest files (like `application.yaml`)

2. **CD Pipeline (ArgoCD)**:
   - Monitors the Git repository for changes
   - Detects differences between Git state and cluster state
   - Automatically syncs the cluster to match the Git repository

## 🛠️ Makefile Commands

| Command              | Description                                     |
| -------------------- | ----------------------------------------------- |
| `make setup`         | Set up the entire environment                   |
| `make install`       | Install dependencies and create cluster         |
| `make port-forward`  | Port forward ArgoCD UI to http://localhost:8080 |
| `make runner-status` | Check GitLab Runner status                      |
| `make runner-update` | Update GitLab Runner configuration              |
| `make delete`        | Delete the K3D cluster                          |
| `make clean`         | Clean up all resources                          |
| `make help`          | Show available commands                         |

## ⚠️ Troubleshooting

| Issue                                  | Solution                                                |
| -------------------------------------- | ------------------------------------------------------- |
| **GitLab Runner not registering**      | Check registration token in `gitlab-runner-values.yaml` |
| **Runner pods stuck in Pending state** | Verify architecture compatibility in helper_image       |
| **CI pipeline fails with permissions** | Ensure proper RBAC configuration is applied             |
| **Image pull failures**                | Check internet connectivity and pull policies           |

## 🔧 Configuration Files

- **`gitlab-runner-values.yaml`**: Helm chart values for GitLab Runner
- **`gitlab-runner-rbac.yaml`**: RBAC permissions for GitLab Runner
- **`makefile`**: Automation commands for managing the environment
- **`scripts/install_gitlab.sh`**: Script for setting up GitLab Runner

## 📝 Notes

- GitLab Runner is configured to use the Kubernetes executor, which creates pods for CI/CD jobs
- For ARM-based systems (Apple Silicon), make sure to use the arm64 helper images
- The runner is registered with tags `k3s`, `kubernetes`, and `local`

<div align="center">
  <sub>Created with ❤️ by Mohammed Belouarraq • June 2025</sub>
</div>

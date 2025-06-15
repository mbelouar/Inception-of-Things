# Inception of Things - Part 3

This part of the project focuses on setting up a CI/CD environment with K3D and ArgoCD on macOS. It automates the deployment of a containerized application (playground) using GitOps principles.

## Project Structure

```
p3/
├── Makefile             # Main automation commands
├── README.md            # This file
├── scripts/             # Setup and utility scripts
│   ├── cleanup.sh       # Cleans up resources
│   ├── create_cluster.sh # Creates the K3D cluster
│   ├── install_argocd.sh # Installs and configures ArgoCD
│   ├── setup_ns.sh      # Sets up required namespaces
│   └── startup.sh       # Main setup script
└── src/                 # Application source files
    ├── application.yaml # ArgoCD application definition
    └── dev/             # Kubernetes manifests for the app
        ├── deployment.yaml # App deployment configuration
        ├── ingress.yaml    # Ingress rules
        └── service.yaml    # Service definition
```

## Prerequisites

- macOS operating system
- Internet connection (to download required packages)

## Installation

You can set up the entire environment with a single command:

```bash
make setup
```

This will:

1. Install all required tools (Docker, kubectl, K3D, ArgoCD)
2. Create a K3D cluster called 'p3'
3. Set up 'dev' and 'argocd' namespaces
4. Install ArgoCD in the cluster
5. Deploy the sample application through ArgoCD

## Available Commands

The following commands are available through the Makefile:

- `make setup`: Install dependencies and deploy application
- `make install`: Install dependencies and create K3D cluster
- `make deploy`: Deploy application with ArgoCD
- `make port-forward`: Port forward ArgoCD UI to localhost:8080
- `make delete`: Delete K3D cluster
- `make clean`: Delete cluster and cleanup resources
- `make help`: Show the help message with available commands

## Accessing ArgoCD UI

After installation, you can access the ArgoCD UI:

```bash
make port-forward
```

Then open https://localhost:8080 in your browser and login with:

- Username: admin
- Password: (shown during installation)

## Application

The demo application deployed is a simple web application (`wil42/playground:v1`) that runs with:

- 2 replicas
- Exposed on port 8888
- Accessible via the hostname 'playground.com' (add to your /etc/hosts for local testing)

## Cleanup

To clean up all resources:

```bash
make clean
```

This will delete the cluster and remove all associated resources.

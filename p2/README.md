# Inception of Things - Part 2: Single-Node K3s with Application Deployment

This part demonstrates deploying multiple applications on a single K3s server with Ingress routing, showing how to manage traffic between applications using Kubernetes' native routing capabilities.

## Overview

Part 2 focuses on application deployment and network routing within a K3s cluster. You'll learn how to:

- Deploy multiple containerized applications
- Configure Kubernetes Ingress resources
- Route traffic based on hostnames
- Set up a default backend service

## Components

- **Server Node (`mbelouarS`)**:
  - IP Address: `192.168.56.110`
  - Deployments:
    - `app1-deployment`: Accessible via `app1.com`
    - `app2-deployment`: Accessible via `app2.com`
    - `app3-deployment`: Accessible as default backend

## Implementation

The implementation uses:

- A single K3s server node created with Vagrant
- YAML configuration files for all Kubernetes resources
- Ingress controller (Traefik, included with K3s)
- Custom container images

## How to Deploy

1. Launch the environment:

   ```bash
   vagrant up
   ```

2. Add hostname entries to your local machine's `/etc/hosts` file:

   ```
   192.168.56.110  app1.com
   192.168.56.110  app2.com
   ```

3. Access the applications:
   - App 1: [http://app1.com](http://app1.com)
   - App 2: [http://app2.com](http://app2.com)
   - Default App: [http://192.168.56.110](http://192.168.56.110)

## Configuration Files

- `app1.yaml`: First application deployment and service
- `app2.yaml`: Second application deployment and service
- `app3.yaml`: Default backend application deployment and service
- `ingress.yaml`: Ingress routing configuration

## Docker Images

The applications use the `mbelouar/hello-kubernetes:arm` container image which runs a simple web server on port 5678, displaying information about the pod, node, and namespace.

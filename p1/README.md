# Inception of Things - Part 1: K3s Multi-Node Cluster

<img src="../images/k3s-logo.png" align="right" width="200">

This part of the project focuses on setting up a basic K3s cluster with server and worker nodes using Vagrant.

## Overview

Part 1 demonstrates how to create a multi-node Kubernetes cluster using K3s, a lightweight Kubernetes distribution perfect for edge computing, IoT applications, and development environments.

## Components

- **Server Node (`mbelouarS`)**:

  - IP Address: `192.168.56.110`
  - Role: K3s server/master
  - Components: K3s, kubectl

- **Worker Node (`mbelouarSW`)**:
  - IP Address: `192.168.56.111`
  - Role: K3s agent/worker
  - Labeled with `node-role.kubernetes.io/worker=worker`

## Implementation

This environment is built using:

- Vagrant for virtual machine provisioning
- K3s for lightweight Kubernetes functionality
- Shell scripts for automated deployment

## How to Deploy

1. Create the token directory for node sharing:

   ```bash
   mkdir -p token
   ```

2. Launch the environment:

   ```bash
   vagrant up
   ```

3. SSH into the server node:

   ```bash
   vagrant ssh mbelouarS
   ```

4. Check the cluster status:
   ```bash
   kubectl get nodes
   ```

You should see both the server and worker nodes in the output, with the worker correctly labeled.

## Network Configuration

The cluster uses `eth1` (192.168.56.110/111) as the primary network interface for K3s communication, configured using the `--flannel-iface eth1` parameter.

## Scripts

- `copy_token.sh`: Shares the K3s token between nodes
- `k3s.sh`: Installs K3s server
- `kubectl.sh`: Installs kubectl
- `label_worker.sh`: Labels the worker node
- `worker.sh`: Configures the worker node

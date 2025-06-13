<div align="center">
  <img src="./images/Inceptionofthings.png" alt="Inception of Things" width="600">

# Inception of Things (IoT)

[![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Vagrant](https://img.shields.io/badge/vagrant-%231563FF.svg?style=for-the-badge&logo=vagrant&logoColor=white)](https://www.vagrantup.com/)
[![K3s](https://img.shields.io/badge/k3s-%230075A8.svg?style=for-the-badge&logo=rancher&logoColor=white)](https://k3s.io/)

This project demonstrates container orchestration using K3s with Vagrant. Create and manage lightweight Kubernetes clusters in virtualized environments, from basic multi-node setups to complete application deployments with Ingress routing.

</div>

## 📦 Project Structure

The project is organized into multiple parts:

### 🔷 Part 1: K3s Multi-Node Cluster

<img src="./images/k3s-logo.png" align="right" width="200">

This part focuses on setting up a basic K3s cluster with server and worker nodes. K3s is a lightweight Kubernetes distribution perfect for edge computing, IoT applications, and development environments.

- **Server Node (`mbelouarS`)**:

  - IP Address: `192.168.56.110`
  - Role: K3s server/master
  - Components: K3s, kubectl

- **Worker Node (`mbelouarSW`)**:
  - IP Address: `192.168.56.111`
  - Role: K3s agent/worker
  - Labeled with `node-role.kubernetes.io/worker=worker`

### 🔷 Part 2: Single-Node K3s with Application Deployment

This part demonstrates deploying multiple applications on a single K3s server with Ingress routing. Learn how to manage traffic between applications using Kubernetes' native routing capabilities.

- **Server Node (`mbelouarS`)**:
  - IP Address: `192.168.56.110`
  - Deployments:
    - `app1-deployment`: Accessible via `app1.com`
    - `app2-deployment`: Accessible via `app2.com`
    - `app3-deployment`: Accessible as default backend

## 🚀 Getting Started

### Prerequisites

- ✅ [Vagrant](https://www.vagrantup.com/downloads) (v2.2.19 or later)
- ✅ [VMware Desktop](https://www.vmware.com/products/workstation-pro.html) (preferred) or VirtualBox
- ✅ Sufficient RAM for VM allocation (minimum 2GB)
- ✅ ARM-based system (project uses ARM64 VM images)

### 🔧 Installation

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd Inception-of-Things
   ```

2. Part 1: Deploy the multi-node K3s cluster

   ```bash
   cd p1
   mkdir -p token  # Create token directory for node sharing
   vagrant up
   ```

   > ℹ️ This creates both server and worker nodes and automatically establishes the cluster connection.

3. Part 2: Deploy the application server

   ```bash
   cd ../p2
   vagrant up
   ```

   > ℹ️ This deploys a single node with three applications and configures the Ingress controller.

### 🌐 Accessing Applications (Part 2)

To access the applications deployed in Part 2:

1. Add the following entries to your `/etc/hosts` file:

   ```
   192.168.56.110  app1.com
   192.168.56.110  app2.com
   ```

2. Access the applications via your browser:

   | Application | URL                                            | Description             |
   | ----------- | ---------------------------------------------- | ----------------------- |
   | App 1       | [http://app1.com](http://app1.com)             | Hello Kubernetes App 1  |
   | App 2       | [http://app2.com](http://app2.com)             | Hello Kubernetes App 2  |
   | Default App | [http://192.168.56.110](http://192.168.56.110) | Default backend (App 3) |

## 🔍 Implementation Details

### Network Configuration

<img src="./images/flannel-logo.png" align="right" width="200">

Both parts use `eth1` (192.168.56.110/111) as the primary network interface for K3s communication, configured using the `--flannel-iface eth1` parameter. This ensures that:

- Cluster internal traffic uses the private network
- Flannel CNI provides proper pod networking
- VM-to-VM communication is isolated from host network traffic

### Deployment Configuration

- **Part 1**: Uses script-based deployment with token sharing between nodes

  ```
  Server (192.168.56.110) ⟹ generates node-token ⟹ Worker (192.168.56.111)
  ```

- **Part 2**: Uses YAML configurations in the `apps-config/` directory to deploy applications with Ingress routing
  ```
  Ingress Controller ⟹ Service ⟹ Deployments ⟹ Pods
  ```

### Docker Images

The applications use the `mbelouar/hello-kubernetes:arm` container image which runs a simple web server on port 5678, displaying information about the pod, node, and namespace.

## ⚠️ Troubleshooting

| Issue                     | Solution                                                                                           |
| ------------------------- | -------------------------------------------------------------------------------------------------- |
| **K3s fails to start**    | Verify that the `eth1` interface is properly configured in your VM. Check with `ip addr show eth1` |
| **Worker not joining**    | Ensure the `token` directory exists and contains the node-token file from the server               |
| **Apps not accessible**   | Verify your `/etc/hosts` file contains the correct entries for app1.com and app2.com               |
| **VMware network issues** | Add `vb.vmx["ethernet0.pcislotnumber"] = "160"` to your VMware provider config in Vagrantfile      |

## 📝 Project Structure

```
.
├── README.md
├── images/
│   └── Inceptionofthings.png
├── p1/                           # Part 1: Multi-node K3s Cluster
│   ├── Vagrantfile               # VM configuration for server and worker
│   ├── scripts/                  # Provisioning scripts
│   │   ├── copy_token.sh         # Share token between nodes
│   │   ├── k3s.sh                # Install K3s server
│   │   ├── kubectl.sh            # Install kubectl
│   │   ├── label_worker.sh       # Label worker node
│   │   └── worker.sh             # Configure worker node
│   └── token/                    # Shared token directory
├── p2/                           # Part 2: Application Deployment
│   ├── Vagrantfile               # VM configuration for app server
│   ├── apps-config/              # Kubernetes resource definitions
│   │   ├── app1.yaml             # First application deployment
│   │   ├── app2.yaml             # Second application deployment
│   │   ├── app3.yaml             # Default application deployment
│   │   └── ingress.yaml          # Ingress routing configuration
│   └── scripts/
│       └── startup.sh            # K3s installation and app deployment
```

## 🔗 Resources

- [K3s Documentation](https://rancher.com/docs/k3s/latest/en/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

<div align="center">
  <sub>Created with ❤️ by Mohammed Belouarraq • June 2025</sub>
</div>

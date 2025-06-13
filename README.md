# Inception of Things (IoT)

This project aims to deepen your knowledge of container orchestration by implementing K3s with Vagrant. It demonstrates how to create and configure Kubernetes clusters in local virtualized environments.

## Project Structure

The project is organized into multiple parts:

### Part 1: K3s Multi-Node Cluster

This part focuses on setting up a basic K3s cluster with server and worker nodes.

- **Server Node (`mbelouarS`)**:

  - IP Address: `192.168.56.110`
  - Role: K3s server/master
  - Components: K3s, kubectl

- **Worker Node (`mbelouarSW`)**:
  - IP Address: `192.168.56.111`
  - Role: K3s agent/worker
  - Labeled with `node-role.kubernetes.io/worker=worker`

### Part 2: Single-Node K3s with Application Deployment

This part demonstrates deploying multiple applications on a single K3s server with Ingress routing.

- **Server Node (`mbelouarS`)**:
  - IP Address: `192.168.56.110`
  - Deployments:
    - `app1-deployment`: Accessible via `app1.com`
    - `app2-deployment`: Accessible via `app2.com`
    - `app3-deployment`: Accessible as default backend

## Getting Started

### Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads)
- [VMware Desktop](https://www.vmware.com/products/workstation-pro.html) (preferred) or VirtualBox
- Sufficient RAM for VM allocation (minimum 2GB)

### Installation

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

3. Part 2: Deploy the application server
   ```bash
   cd ../p2
   vagrant up
   ```

### Accessing Applications (Part 2)

To access the applications deployed in Part 2:

1. Add the following entries to your `/etc/hosts` file:

   ```
   192.168.56.110  app1.com
   192.168.56.110  app2.com
   ```

2. Access the applications via your browser:
   - First application: http://app1.com
   - Second application: http://app2.com
   - Third application: http://192.168.56.110 (default)

## Implementation Details

### Network Configuration

Both parts use `eth1` (192.168.56.110/111) as the primary network interface for K3s communication, configured using the `--flannel-iface eth1` parameter.

### Deployment Configuration

- **Part 1**: Uses script-based deployment with token sharing between nodes.
- **Part 2**: Uses YAML configurations in the `apps-config/` directory to deploy applications with Ingress routing.

### Docker Images

The applications use the `mbelouar/hello-kubernetes:arm` container image which runs a simple web server on port 5678.

## Troubleshooting

- **Network Issues**: If K3s fails to start, verify that the `eth1` interface is properly configured in your VM.
- **Token Sharing**: For Part 1, ensure the `token` directory exists before running `vagrant up`.
- **Host Resolution**: If applications are not accessible, verify your `/etc/hosts` file contains the correct entries.

## Resources

- [K3s Documentation](https://rancher.com/docs/k3s/latest/en/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

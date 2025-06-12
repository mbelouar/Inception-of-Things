#!/bin/bash

set -e

NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"

# Wait for K3s token to exist
while [ ! -f "$NODE_TOKEN" ]; do
  echo "Waiting for node-token..."
  sleep 2
done

# Copy token and kubeconfig to synced folder
sudo cp "$NODE_TOKEN" /vagrant/
sudo cp "$KUBE_CONFIG" /vagrant/

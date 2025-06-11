#!/bin/bash

echo "Validating K3s cluster..."

# Check K3s service is running
if ! systemctl is-active --quiet k3s; then
  echo "K3s service is not running on server"
  systemctl status k3s
  exit 1
fi

# Wait for the node to become ready
echo "Waiting for nodes to become ready..."
sleep 10

# List nodes
echo "Cluster nodes:"
sudo kubectl get nodes -o wide

# Check for any issues
echo "Checking for any issues..."
sudo kubectl get pods -A | grep -v Running | grep -v Completed

echo "Validation complete"


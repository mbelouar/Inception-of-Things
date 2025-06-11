#!/bin/bash

SERVER_IP="192.168.56.110"
NODE_IP="192.168.56.111"

# Wait until token file is available
while [ ! -f /vagrant/node-token ]; do
  echo "Waiting for token file..."
  sleep 5
done

TOKEN=$(cat /vagrant/node-token)
echo "Token found. Joining cluster..."

# Install K3s agent with specific network interface configuration
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="--node-ip=${NODE_IP} --flannel-iface=eth1" sh -

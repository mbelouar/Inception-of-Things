#!/bin/bash

echo "Waiting for K3s to finish startup..."

# Wait until K3s service is active
while ! systemctl is-active --quiet k3s; do
  sleep 2
done

TOKEN_PATH="/var/lib/rancher/k3s/server/node-token"
DEST="/vagrant/node-token"

echo "Waiting for K3s token file..."
while [ ! -f "$TOKEN_PATH" ]; do
  sleep 2
done

echo "Copying token to synced folder..."
sudo cp "$TOKEN_PATH" "$DEST"

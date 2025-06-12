#!/bin/bash

set -e

sudo apt-get update && sudo apt-get upgrade -y

if [ ! -f /usr/local/bin/kubectl ]; then
  echo "[INFO] Downloading kubectl..."
  KUBECTL_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
  curl -L --retry 5 --retry-delay 10 --output kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/arm64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
else
  echo "[INFO] kubectl already exists."
fi

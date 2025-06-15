#!/bin/bash

# Colors
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Check cluster access
if ! kubectl cluster-info &>/dev/null; then
    print_warning "Kubernetes cluster not accessible. Skipping cleanup."
    exit 0
fi

print_status "Starting cleanup..."

# Delete ArgoCD applications (some may use finalizers)
print_status "Deleting ArgoCD Applications..."
kubectl delete applications --all -A --timeout=20s 2>/dev/null || true

# Clean selected namespaces
for ns in dev argocd; do
    if kubectl get ns "$ns" &>/dev/null; then
        print_status "Deleting namespace '$ns'..."
        kubectl delete namespace "$ns" --timeout=30s || \
        kubectl delete namespace "$ns" --force --grace-period=0
    else
        print_warning "Namespace '$ns' not found. Skipping..."
    fi
done

# Delete PVCs and PVs globally (optional if you use local-path provisioner)
print_status "Deleting PVCs and PVs..."
kubectl delete pvc --all -A --timeout=15s 2>/dev/null || true
kubectl delete pv --all --timeout=15s 2>/dev/null || true

print_status "Cleanup done!"

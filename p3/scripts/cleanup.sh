#!/bin/bash

# Colors for output
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Clean up all resources in the 'dev' namespace
cleanup_dev_namespace() {
    print_status "Cleaning up 'dev' namespace..."
    
    # Check if kubectl can connect to the cluster
    if ! kubectl cluster-info &>/dev/null; then
        print_warning "Kubernetes cluster is not accessible, skipping 'dev' namespace cleanup"
        return 0
    fi
    
    # Check if the namespace exists before trying to delete resources
    if ! kubectl get namespace dev &>/dev/null; then
        print_warning "'dev' namespace doesn't exist, skipping cleanup"
        return 0
    fi
    
    # Delete all resources in the 'dev' namespace
    kubectl delete all --all -n dev --timeout=30s
    
    if [ $? -eq 0 ]; then
        print_status "'dev' namespace cleaned up successfully"
    else
        print_warning "Failed to clean up all resources in 'dev' namespace, continuing anyway"
    fi
    
    # Optionally delete the namespace itself
    kubectl delete namespace dev --timeout=30s
    
    if [ $? -eq 0 ]; then
        print_status "'dev' namespace deleted"
    else
        print_warning "Failed to delete 'dev' namespace, continuing anyway"
    fi
}

# Clean up all resources in the 'argocd' namespace
cleanup_argocd_namespace() {
    print_status "Cleaning up 'argocd' namespace..."
    
    # Check if kubectl can connect to the cluster
    if ! kubectl cluster-info &>/dev/null; then
        print_warning "Kubernetes cluster is not accessible, skipping 'argocd' namespace cleanup"
        return 0
    fi
    
    # Check if the namespace exists before trying to delete resources
    if ! kubectl get namespace argocd &>/dev/null; then
        print_warning "'argocd' namespace doesn't exist, skipping cleanup"
        return 0
    fi
    
    # Delete all resources in the 'argocd' namespace
    kubectl delete all --all -n argocd --timeout=30s
    
    if [ $? -eq 0 ]; then
        print_status "'argocd' namespace cleaned up successfully"
    else
        print_warning "Failed to clean up all resources in 'argocd' namespace, continuing anyway"
    fi
    
    # Delete the namespace itself
    kubectl delete namespace argocd --timeout=30s
    
    if [ $? -eq 0 ]; then
        print_status "'argocd' namespace deleted"
    else
        print_warning "Failed to delete 'argocd' namespace, continuing anyway"
    fi
}

# Execute the cleanup functions
cleanup_dev_namespace
cleanup_argocd_namespace

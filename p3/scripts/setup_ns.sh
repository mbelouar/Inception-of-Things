#!/bin/bash

# Setup Kubernetes namespaces
setup_namespaces() {
    print_status "Setting up Kubernetes namespaces..."
    
    namespaces=("argocd" "dev")
    
    for ns in "${namespaces[@]}"; do
        kubectl create namespace "$ns" 2>/dev/null || print_warning "Namespace '$ns' already exists"
    done
    
    print_status "Available namespaces:"
    kubectl get namespaces
}

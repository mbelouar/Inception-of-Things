#!/bin/bash

# Install ArgoCD
install_argocd() {
    print_status "Installing ArgoCD..."
    
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    
    if [ $? -eq 0 ]; then
        print_status "ArgoCD installed successfully"
    else
        print_error "Failed to install ArgoCD"
        exit 1
    fi

    print_status "Waiting for ArgoCD server to be ready..."
    kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s

    # change the default admin password
    print_status "Changing default admin password..."
    kubectl -n argocd patch secret argocd-secret \
        -p '{"stringData": {"admin.password": "$2a$10$rRyBkqmXUY9rOHXcvfWQBOQXllYJzqNhGWKvyY8EXz8oUK7QoJHse"}}' \
        --type=merge
    if [ $? -eq 0 ]; then
        print_status "Default admin password changed successfully"
    else
        print_error "Failed to change default admin password"
        exit 1
    fi
    
    print_status "ArgoCD installation complete!"
    print_status "To access ArgoCD UI:"
    print_status "  1. Run: kubectl port-forward svc/argocd-server -n argocd 8080:443"
    print_status "  2. Open: https://localhost:8080 (note: HTTPS, not HTTP)"
    print_status "  3. Login with username 'admin' and your password"
    print_status "  4. Accept the self-signed certificate warning"
}

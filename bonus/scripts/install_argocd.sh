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

    # Get the default admin password
    print_status "Getting the default admin password..."
    ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    if [ $? -eq 0 ]; then
        print_status "Retrieved initial admin password successfully"
        print_status "ArgoCD admin password: $ARGOCD_PASSWORD"
    else
        print_error "Failed to retrieve initial admin password"
        exit 1
    fi
    
    print_status "ArgoCD installation complete!"
    print_status "To access ArgoCD UI:"
    print_status "  1. Run: make port-forward"
    print_status "  2. Open: https://localhost:8080 (note: HTTPS, not HTTP)"
    print_status "  3. Login with username 'admin' and your password"
    print_status "  4. Accept the self-signed certificate warning"
}
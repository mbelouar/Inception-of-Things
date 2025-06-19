#!/bin/bash

# Install GitLab using Helm
install_gitlab() {
    print_status "Installing GitLab..."

    # Add GitLab Helm repository
    helm repo add gitlab https://charts.gitlab.io
    helm repo update
    if [ $? -ne 0 ]; then
        print_error "Failed to add GitLab Helm repository"
        exit 1
    fi  
    print_status "GitLab Helm repository added successfully"

   helm upgrade --install gitlab gitlab/gitlab \
        -f helm/gitlab-values.yaml \
        --namespace gitlab

    if [ $? -ne 0 ]; then
        print_error "Failed to install GitLab"
        exit 1
    fi 
    print_status "GitLab installed successfully"
    print_status "Waiting for GitLab to be ready..."    
    kubectl wait --for=condition=available deployment/gitlab-webservice-default -n gitlab 
    print_status "GitLab is now ready!"
    print_status "To access GitLab UI:"
    print_status "  1. Run: make port-forward-gitlab"
    print_status "  2. Open: http://localhost:8080"
    print_status "  3. Login with username 'root' and password '5iveL!fe' (default credentials)"
    print_status "  4. Change the password on first login"
    print_status "  5. Accept the self-signed certificate warning if prompted"
    print_status "  6. Enjoy your GitLab instance!"
}

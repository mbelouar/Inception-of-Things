#!/bin/bash

# Install GitLab using Helm
install_gitlab() {
    print_status "Installing GitLab Runner..."

    # Add GitLab Helm repository
    helm repo add gitlab https://charts.gitlab.io
    helm repo update
    if [ $? -ne 0 ]; then
        print_error "Failed to add GitLab Helm repository"
        exit 1
    fi  
    print_status "GitLab Helm repository added successfully"

    # Check if runner values file exists
    if [ ! -f "helm/gitlab-runner-values.yaml" ]; then
        print_error "GitLab Runner values file nsnot found at helm/gitlab-runner-values.yaml"
        print_status "Please create the values file with your GitLab URL and registration token"
        exit 1
    fi

    # Install GitLab Runner
    print_status "Installing GitLab Runner with Helm..."
    helm upgrade --install gitlab-runner gitlab/gitlab-runner \
        -n gitlab \
        -f helm/gitlab-runner-values.yaml


    if [ $? -ne 0 ]; then
        print_error "Failed to install GitLab Runner"
        exit 1
    fi 
    print_status "GitLab Runner installed successfully"

    print_status "Waiting for GitLab Runner to be ready..."
    kubectl wait --for=condition=available deployment/gitlab-runner -n gitlab --timeout=300s
    if [ $? -ne 0 ]; then
        print_error "GitLab Runner deployment did not become available in time"
        exit 1
    fi
    print_status "GitLab Runner installation complete and it is ready to use!"
    print_status "To check the runner in the gitlab UI:"
    print_status "  1. Open your GitLab instance in a browser"
    print_status "  2. Go to 'Settings' -> 'CI / CD' -> 'Runners'"
    print_status "  3. You should see the GitLab Runner listed there"
}
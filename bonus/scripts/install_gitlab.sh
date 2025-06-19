#!/bin/bash

# Install GitLab using Helm
install_gitlab() {
    print_status "Installing GitLab..."

    # Add GitLab Helm repository
    helm repo add gitlab https://charts.gitlab.io
    helm repo update

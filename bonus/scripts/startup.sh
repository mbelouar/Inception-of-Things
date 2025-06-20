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

# Check if running on macOS
check_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_status "Detected macOS system"
        return 0
    else
        print_error "This script is designed for macOS only"
        exit 1
    fi
}

# Install required tools
install_tools() {
    print_status "Installing required tools..."
    
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        print_status "Homebrew already installed"
    fi
    
    # Install basic tools with brew
    brew install curl wget git

    # Add helm to the list of tools to install
    tools=("docker" "kubectl" "k3d" "argocd" "helm")
    for tool in "${tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            print_status "$tool already installed"
        else
            if [ "$tool" = "docker" ]; then
                brew install --cask docker
            else
                brew install "$tool"
            fi

            if [ $? -eq 0 ]; then
                print_status "$tool installed successfully"
            else
                print_error "Failed to install $tool"
                exit 1
            fi
        fi
    done
}


main() {
    print_status "Starting K3D setup process..."
    
    check_os
    install_tools
    source ./scripts/create_cluster.sh
    create_cluster
    source ./scripts/setup_ns.sh
    setup_namespaces
    source ./scripts/install_argocd.sh
    install_argocd
    # install gitlab locally using helm (bonus part)
    source ./scripts/install_gitlab.sh
    install_gitlab
    print_status "Setup completed successfully!"
}

# Run the main function
main
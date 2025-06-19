#!/bin/bash

# Create K3D cluster
create_cluster() {
    print_status "Creating K3D cluster named 'p3'..."
    
    if k3d cluster list | grep -q "p3"; then
        print_warning "Cluster 'p3' already exists"
        echo -n "Delete existing cluster and recreate? [y/N]: "
        read -r response
        
        if [[ "$response" =~ ^[Yy]$ ]]; then
            k3d cluster delete p3
            print_status "Old cluster deleted"
        else
            print_status "Using existing cluster"
            return 0
        fi
    fi
    
    # Create cluster with port mappings for ingress
    k3d cluster create p3 \
        --port "80:80@loadbalancer" \
        --port "443:443@loadbalancer" \
        --api-port 6550
    
    if [ $? -ne 0 ]; then
        print_error "Failed to create cluster"
        exit 1
    fi
    
    print_status "Cluster created successfully"
    kubectl cluster-info
}

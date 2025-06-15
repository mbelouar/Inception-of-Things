# Default target
all: help

# Setup the entire infrastructure
setup: install deploy
	@echo "Setup complete! Access ArgoCD UI with 'make port-forward'"

# Install dependencies and create cluster
install:
	@echo "Installing dependencies and creating cluster..."
	@bash ./scripts/startup.sh

# Deploy ArgoCD application
deploy:
	@echo "Deploying application..."
	@kubectl apply -f ./src/application.yaml

# Port forward ArgoCD UI
port-forward:
	@echo "Port forwarding ArgoCD UI..."
	@kubectl port-forward svc/argocd-server -n argocd 8080:443
	@echo "Access ArgoCD UI at http://localhost:8080"

# Delete cluster
delete:
	@echo "Deleting cluster..."
	@k3d cluster delete p3 2>/dev/null || echo "Cluster already deleted or not found"

# Clean everything thoroughly
clean:
	@echo "Cleaning up resources before deleting cluster..."
	@bash ./scripts/cleanup.sh
	@echo "Deleting cluster..."
	@k3d cluster delete p3 2>/dev/null || echo "Cluster already deleted or not found"
	@echo "Cleanup complete!"


# Show help
help:
	@echo "Available targets:"
	@echo "  setup        - Install dependencies and deploy application"
	@echo "  install      - Install dependencies and create K3d cluster"
	@echo "  deploy       - Deploy application with ArgoCD"
	@echo "  port-forward - Port forward ArgoCD UI"
	@echo "  delete       - Delete K3d cluster"
	@echo "  clean        - Delete cluster and cleanup resources"
	@echo "  help         - Show this help message"

.PHONY: all setup clean delete install deploy port-forward help

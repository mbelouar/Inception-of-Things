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
	@k3d cluster delete p3

# Clean everything
clean: delete
	@echo "Cleaning up resources..."
	@kubectl delete -f ./src/application.yaml 2>/dev/null || echo "Application already deleted or cluster not accessible"
	@bash ./scripts/cleanup.sh

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

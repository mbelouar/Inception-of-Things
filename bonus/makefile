# ANSI color codes
GREEN=\033[1;32m
NC=\033[0m

# Default target
all: help

# Setup the entire infrastructure
setup: install deploy
	@echo "$(GREEN)Setup complete! Access ArgoCD UI with 'make port-forward'$(NC)"

# Install dependencies and create cluster
install:
	@echo "$(GREEN)Installing dependencies and creating cluster...$(NC)"
	@bash ./scripts/startup.sh

# Deploy ArgoCD application
deploy:
	@echo "$(GREEN)Deploying application...$(NC)"
	@kubectl apply -f ./src/application.yaml

# Port forward ArgoCD UI
port-forward:
	@echo "$(GREEN)Port forwarding ArgoCD UI...$(NC)"
	@kubectl port-forward svc/argocd-server -n argocd 8080:443
	@echo "$(GREEN)Access ArgoCD UI at http://localhost:8080$(NC)"

port-forward-gitlab:
	@echo "$(GREEN)Port forwarding GitLab UI...$(NC)"
	@kubectl port-forward svc/gitlab-webservice-default -n gitlab 8081:8080
	@echo "$(GREEN)Access GitLab UI at http://localhost:8081$(NC)"

# Delete cluster
delete:
	@echo "$(GREEN)Deleting cluster...$(NC)"
	@k3d cluster delete p3 2>/dev/null || echo "$(GREEN)Cluster already deleted or not found$(NC)"

# Clean everything thoroughly
clean:
	@echo "$(GREEN)Cleaning up resources before deleting cluster...$(NC)"
	@bash ./scripts/cleanup.sh
	@echo "$(GREEN)Deleting cluster...$(NC)"
	@k3d cluster delete p3 2>/dev/null || echo "$(GREEN)Cluster already deleted or not found$(NC)"
	@echo "$(GREEN)Cleanup complete!$(NC)"

# Show help
help:
	@echo "$(GREEN)Available targets:$(NC)"
	@echo "$(GREEN)  setup        - Install dependencies and deploy application$(NC)"
	@echo "$(GREEN)  install      - Install dependencies and create K3d cluster$(NC)"
	@echo "$(GREEN)  deploy       - Deploy application with ArgoCD$(NC)"
	@echo "$(GREEN)  port-forward - Port forward ArgoCD UI$(NC)"
	@echo "$(GREEN)  delete       - Delete K3d cluster$(NC)"
	@echo "$(GREEN)  clean        - Delete cluster and cleanup resources$(NC)"
	@echo "$(GREEN)  help         - Show this help message$(NC)"

.PHONY: all setup clean delete install deploy port-forward help

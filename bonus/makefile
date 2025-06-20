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

# Check GitLab Runner status
runner-status:
	@echo "$(GREEN)Checking GitLab Runner status...$(NC)"
	@kubectl get pods -n gitlab
	@echo "$(GREEN)Runner logs:$(NC)"
	@kubectl logs -n gitlab deployment/gitlab-runner --tail=20

# Update GitLab Runner configuration
runner-update:
	@echo "$(GREEN)Updating GitLab Runner configuration...$(NC)"
	@helm upgrade gitlab-runner gitlab/gitlab-runner -f helm/gitlab-runner-values.yaml -n gitlab

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
	@echo "$(GREEN)  setup         - Install dependencies and deploy application$(NC)"
	@echo "$(GREEN)  install       - Install dependencies and create K3d cluster$(NC)"
	@echo "$(GREEN)  deploy        - Deploy application with ArgoCD$(NC)"
	@echo "$(GREEN)  port-forward  - Port forward ArgoCD UI$(NC)"
	@echo "$(GREEN)  runner-status - Check GitLab Runner status$(NC)"
	@echo "$(GREEN)  runner-update - Update GitLab Runner configuration$(NC)"
	@echo "$(GREEN)  delete        - Delete K3d cluster$(NC)"
	@echo "$(GREEN)  clean         - Delete cluster and cleanup resources$(NC)"
	@echo "$(GREEN)  help          - Show this help message$(NC)"

.PHONY: all setup clean delete install deploy port-forward runner-status runner-update help
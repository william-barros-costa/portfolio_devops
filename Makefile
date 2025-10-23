# ------- Variables ------------
ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TERRAFORM_INFRA = "terraform"
TERRAFORM_DEPLOY = "terraform/deployment"
ANSIBLE_DIR = "ansible"

test:
	@echo "dir: $(ROOT)"

infra:
	@echo "🚀 Provisioning infrastructure with Terraform..."
	terraform -chdir=$(TERRAFORM_INFRA) init
	terraform -chdir=$(TERRAFORM_INFRA) apply -auto-approve

config:
	@echo "⚙️  Running Ansible playbook to configure nodes and install Kubernetes..."
	cd $(TERRAFORM_INFRA) && terraform output -json > ../$(ANSIBLE_DIR)/inventory/terraforms_outputs.json
	cd $(ANSIBLE_DIR) && ansible-playbook -i inventory


deploy:
	@echo "📦 Deploying cluster tools via Terraform..."
	terraform -chdir=$(TERRAFORM_DEPLOY) init
	terraform -chdir=$(TERRAFORM_DEPLOY) apply -auto-approve

destroy:
	@echo "🔥 Destroying all Terraform-managed resources..."
	terraform -chdir=$(TERRAFORM_DEPLOY) destroy -auto-approve || true
	terraform -chdir=$(TERRAFORM_INFRA) destroy -auto-approve

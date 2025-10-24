# ------- Variables ------------
ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TERRAFORM_INFRA = "terraform/infrastructure"
TERRAFORM_DEPLOY = "terraform/deployment"
ANSIBLE_DIR = "ansible"

test:
	@echo "dir: $(ROOT)"

infra:
	@echo "🚀 Provisioning infrastructure with Terraform..."
	cd $(TERRAFORM_INFRA) && terraform init
	cd $(TERRAFORM_INFRA) && terraform apply -auto-approve

ping:
	@echo "📡  Ping infrastructure through Ansible..."
	ansible cluster -m ping -i resources/inventory.ini

config:
	@echo "⚙️  Running Ansible playbook to configure nodes and install Kubernetes..."
	cd $(ANSIBLE_DIR) && ansible-playbook -i inventory.ini playbook.yml

deploy:
	@echo "📦 Deploying cluster tools via Terraform..."
	cd $(TERRAFORM_DEPLOY) && terraform init
	cd $(TERRAFORM_DEPLOY) && terraform apply -auto-approve

destroy:
	@echo "🔥 Destroying all Terraform-managed resources..."
	cd $(TERRAFORM_DEPLOY) && terraform destroy -auto-approve || true
	cd $(TERRAFORM_INFRA) && terraform destroy -auto-approve

resource "tls_private_key" "ssh_key" {
   algorithm = "ECDSA"
   ecdsa_curve = "P384"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/id_rsa"
  file_permission = "0600"
}

module "local-cloud" {
  source = "./local-cloud"
  ssh_public_key = tls_private_key.ssh_key.public_key_openssh
}

output "addresses" {
  value = module.local-cloud.vm_ip
}

# module "kubernetes" {
#   source = "./kubernetes"
#   private_key = tls_private_key.ssh_key.private_key_pem
#   vm_ip = module.local-cloud.vm_ip 
# }

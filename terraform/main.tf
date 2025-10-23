
module "local-cloud" {
  source = "./local-cloud"
  ssh_public_key = tls_private_key.ssh_key.public_key_openssh
}

output "addresses" {
  value = module.local-cloud.vm_ips
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl", {
     addresses = module.local-cloud.vm_ips
     user = module.local-cloud.username
     ssh_key_path = module.local-cloud.ssh_key_path
  })
  filename = "${path.module}/../ansible/inventory.ini"
}

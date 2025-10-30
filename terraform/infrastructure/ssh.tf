resource "tls_private_key" "ssh_key" {
   algorithm = "ECDSA"
   ecdsa_curve = "P384"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${local.root}/${local.ssh_key_location}"
  file_permission = var.ssh_key_permission
}

resource "null_resource" "add_to_known_host" {
  depends_on = [libvirt_domain.vm]

  provisioner "local-exec" {
    command = "sleep 10 && ssh-keyscan -H ${libvirt_domain.vm.network_interface.0.addresses.0} 2>/dev/null >> ~/.ssh/known_hosts"
  }
}


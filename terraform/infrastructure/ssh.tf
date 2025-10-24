resource "tls_private_key" "ssh_key" {
   algorithm = "ECDSA"
   ecdsa_curve = "P384"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${local.root}/${local.ssh_key_location}"
  file_permission = var.ssh_key_permission
}

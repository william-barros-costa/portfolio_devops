resource "tls_private_key" "ssh_key" {
   algorithm = "ECDSA"
   ecdsa_curve = "P384"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/id_rsa"
  file_permission = "0600"
}

output "ssh_private_key" {
  sensitive = true
  value = tls_private_key.ssh_key.private_key_openssh
}

output "ips" {
  description = "Ips of the created cloud virtual machhine"
  value = libvirt_domain.vm.network_interface.0.addresses
}

output "user" {
  description = "Normal user created in the master kubernetes vm"
  value = var.user
}

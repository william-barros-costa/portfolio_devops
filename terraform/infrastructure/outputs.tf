output "ips" {
  description = "Ips of the created cloud virtual machhine"
  value = local.vm_addresses
}

output "user" {
  description = "Normal user created in the master kubernetes vm"
  value = var.user
}

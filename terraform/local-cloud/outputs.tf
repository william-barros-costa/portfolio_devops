output "vm_ip" {
  description = "Ip of the created cloud virtual machhine"
  value = libvirt_domain.vm.network_interface.0.addresses.0
}

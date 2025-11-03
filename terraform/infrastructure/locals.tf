# Locals
locals {
  root = "${path.module}/../.."
  ssh_key_location = "resources/id_rsa"
  user_data = templatefile("${path.module}/templates/user_data.cfg.tpl", {
    user = var.user
    password = var.password
    ssh_authorized_key = tls_private_key.ssh_key.public_key_openssh
  })
  network_data = file("${path.module}/templates/network_data.cfg.tpl")
  vm_addresses = {
    for name, vm in libvirt_domain.vm:
    name => vm.network_interface[0].addresses[0]
  }
  ansible_inventory_location = "${local.root}/resources/inventory.ini"
  ansible_inventory = templatefile("${path.module}/templates/inventory.ini.tpl", {
    vms = var.virtual_machines 
    addresses = local.vm_addresses
    user = var.user
    ssh_key_path = local.ssh_key_location
  })
}

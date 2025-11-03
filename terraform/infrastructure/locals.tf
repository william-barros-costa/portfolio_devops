# Locals
locals {
  root = "${path.module}/../.."
  ssh_key_location = "resources/id_rsa"
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

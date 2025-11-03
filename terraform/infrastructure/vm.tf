resource "libvirt_pool" "ubuntu" {
  name = "ubuntu"
  type = "dir"
  target {
    path = var.volume_location
  }
}

resource "libvirt_volume" "ubuntu_image" {
  for_each = { for vm in var.virtual_machines: vm.name => vm}

  name = "ubuntu-24.04-noble-${each.key}.qcow2"
  pool = "default"
  source = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "vm_disk" {
  for_each = { for vm in var.virtual_machines: vm.name => vm}

  name = each.key
  pool = "default"
  # Conversion to gigabytes
  size = each.value.size * 1024 * 1024 * 1024
  base_volume_id = libvirt_volume.ubuntu_image[each.key].id
  format = "qcow2"
}


resource "libvirt_cloudinit_disk" "commoninit" {

  name = "commoninit.iso"
  user_data = local.user_data
  network_config = local.network_data
  pool = libvirt_pool.ubuntu.name
}

resource "libvirt_domain" "vm" {
  for_each = { for vm in var.virtual_machines: vm.name => vm}

  name = each.key
  memory = each.value.memory
  vcpu = each.value.vcpu

  network_interface {
    network_name= "default" 
    wait_for_lease = true
  }

  disk { 
    volume_id = libvirt_volume.vm_disk[each.key].id 
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }
  cloudinit = libvirt_cloudinit_disk.commoninit.id
}


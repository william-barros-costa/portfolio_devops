resource "libvirt_pool" "ubuntu" {
  name = "ubuntu"
  type = "dir"
  target {
    path = "/tmp/portfolio"
  }
}

resource "libvirt_volume" "ubuntu_image" {
  name = "ubuntu-24.04-noble.qcow2"
  pool = "default"
  source = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "vm_disk" {
  name = "master"
  pool = "default"
  size = 10*1024*1024*1024
  base_volume_id = libvirt_volume.ubuntu_image.id
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.cfg")
  vars = {
    ssh_authorized_key = var.ssh_public_key
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_data.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool = libvirt_pool.ubuntu.name
}

resource "libvirt_domain" "vm" {
  name = "server"
  memory = 4096
  vcpu = 4

  network_interface {
    network_name= "default" 
  }

  disk { 
    volume_id = libvirt_volume.vm_disk.id 
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


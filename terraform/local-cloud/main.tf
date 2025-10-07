
resource "libvirt_network" "kube_network" {
  name = "k8snet"
  mode = "nat"
  domain = "k8s.local"
  addresses = ["192.168.250.0/24"]
  autostart = true
  dhcp { enabled = true }
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
  size = 5*1024*1024*1024
  base_volume_id = libvirt_volume.ubuntu_image.id
  format = "qcow2"
}

resource "libvirt_domain" "vm" {
  name = "server"
  memory = 2048
  vcpu = 2
  network_interface {network_name= "default" }
  disk { volume_id = libvirt_volume.vm_disk.id }
  graphics {
    type = "spice"
    listen_type = "none"
  }
  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }

}

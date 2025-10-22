resource "null_resource" "install_kubernetes" {
#  triggers = {
#    vm_ip = var.vm_ip
#  }
  connection {
    host = var.vm_ip
    user = "ubuntu"
    private_key = var.private_key
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y"
    ]
  }
}

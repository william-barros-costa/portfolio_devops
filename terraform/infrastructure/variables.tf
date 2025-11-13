variable "volume_location" {
  description = "Location to store the virtual machine data"
}

variable "volume_name" {
  default = "server_volume"
}

variable "ssh_key_permission" {
  default = "0600"
  description = "Unix permissions given to the generated ssh key"
}

variable "user" {
  description = "Username of the user to create on virtual machine"
  type = string
}

variable "password" {
  description = "Password of the user to create on virtual machine"
  type = string
}

variable "virtual_machines" {
  type = list(object({
    name = string
    memory = number
    vcpu = number
    size = number
  }))

  default = [
    { name = "master",  memory = 6144, vcpu = 2, size = 150 },
    { name = "worker1", memory = 8192, vcpu = 3, size = 50 },
    { name = "worker2", memory = 8192, vcpu = 3, size = 50 },
  ]
}

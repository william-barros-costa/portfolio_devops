variable "volume_location" {
  default = "/tmp/portfolio" 
  description = "Location to store the virtual machine data"
}

variable "volume_size" {
  description = "Size, in Gigabytes, of the virtual machine disk"
  default = 10 
}

variable "server_name" {
  default = "ubuntu"
}

variable "volume_name" {
  default = "server_volume"
}

variable "ssh_key_permission" {
  default = "0600"
  description = "Unix permissions given to the generated ssh key"
}

variable "vcpu" {
  default = "4"
  description = "Amount of virtual cpus given to the virtual machine"
}

variable "memory" {
  default = "4096"
  description = "Amount of memory given to the virtual machine"
}

variable "user" {
  description = "Username of the user to create on virtual machine"
  type = string
}

variable "password" {
  description = "Password of the user to create on virtual machine"
  type = string
}

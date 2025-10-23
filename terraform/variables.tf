variable "app_name" {
  
}

variable "volume_size" {
  description = "Size, in Gigabytes, of the virtual machine disk"
  default = 10 
}

variable "network_cidr" {
  description = "Private subnet used by NAT network"
  default = "192.168.130.0/24"
  type = string
}

variable "ssh_public_key" {
  type = string
  description = "SSH public key for login"
}

variable "ssh_key_path" {
  description = "SSH private fullpath"
  default = "./id_rsa"
}

variable "network_cidr" {
  description = "Private subnet used by NAT network"
  default = "192.168.130.0/24"
  type = string
}

variable "ssh_public_key" {
  type = string
  description = "SSH public key for login"
}

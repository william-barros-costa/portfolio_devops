resource "local_file" "ansible_inventory" {
  content = local.ansible_inventory
  filename = local.ansible_inventory_location
}

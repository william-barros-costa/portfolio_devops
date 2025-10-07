resource "utilities_file_downloader" "server_iso" {
	url = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
	filename = var.server_image
}

module "local-cloud" {
  source = "./local-cloud"
  server_image = var.server_image
}



resource "digitalocean_droplet" "homelab" {
  image = "ubuntu-22-04-x64"
  name = "turbochungus"
  region = "nyc2"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}
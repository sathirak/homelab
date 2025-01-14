resource "digitalocean_droplet" "homelab" {
  image  = "ubuntu-22-04-x64"
  name   = "turbochungus"
  region = "sfo3"
  size   = "s-2vcpu-2gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~",
      "git clone https://github.com/sathirak/homelab.git",
      "chmod +x ~/homelab/setup.sh",
      "~/homelab/setup.sh",
      "echo This is your Homelab IP $(hostname -I | cut -d' ' -f1)"
    ]
  }
}

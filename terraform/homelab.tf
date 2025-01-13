resource "digitalocean_droplet" "homelab" {
  image  = "ubuntu-22-04-x64"
  name   = "turbochungus"
  region = "sfo3"
  size   = "s-1vcpu-1gb"
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
      "apt-get update -y",
      "apt-get install -y nginx",

      "git clone https://github.com/sathirak/homelab.git",

      "rm -rf /var/www/html/*",
      "cp ./homelab/nginx/* /var/www/html/",

      "rm -rf ./homelab",
      "systemctl restart nginx",

      "echo This is your Homelab IP $(hostname -I | cut -d' ' -f1)"
    ]
  }
}

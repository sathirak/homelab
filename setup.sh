#!/bin/bash

set -e

echo "🏠 > Starting installation of Docker, Minikube, and kubectl..."

# Install Docker, see the blog I reffered to
#  https://docs.docker.com/engine/install/ubuntu/
echo "🏠 > Installing system dependencies..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

echo "🏠 > Installing Docker..."

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg || true
done

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

curl -sfL https://get.k3s.io | sh -

sudo chmod 644 /etc/rancher/k3s/k3s.yaml
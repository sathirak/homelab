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

# Install Minikube, see the blog I reffered to
# https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download
# echo "🏠 > Installing Minikube..."
# curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube
# rm minikube-linux-amd64

# Install kubectl, see the blog I reffered to
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
echo "🏠 > Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

sudo usermod -aG docker $USER

minikube start --force
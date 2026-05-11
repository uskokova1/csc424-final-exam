#!/bin/bash

set -e

echo "🔄 Updating system..."
sudo apt-get update -y

echo "📦 Installing prerequisites..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔑 Adding Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating package list (Docker repo)..."
sudo apt-get update -y

echo "🐳 Installing Docker + Compose..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "👤 Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "🚀 Enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "✅ Installation complete!"

echo ""
echo "⚠️ IMPORTANT: Log out and back in (or run 'newgrp docker') to use docker without sudo."
echo ""

echo "🔍 Versions:"
docker --version
docker compose version

#!/usr/bin/env bash
set -euo pipefail

# Update package lists and install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl git gnupg lsb-release

# Add Docker's official GPG key and repository
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker and its components
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to the docker group (optional)
if ! groups $USER | grep -q docker; then
  sudo usermod -aG docker $USER
  echo "Added $USER to docker group. Please log out and log back in for group changes to take effect."
fi

echo "Bootstrap completed. Docker and docker-compose are installed."

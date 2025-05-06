#!/bin/bash



# Update system
echo -e "\e[34mUpdating system packages...\e[0m"
sudo apt-get update > /dev/null 2>&1

# Install Docker if not present
if ! command -v docker > /dev/null 2>&1; then
    echo -e "\e[34mInstalling Docker...\e[0m"
    sudo apt-get install -y docker.io > /dev/null 2>&1
    sudo systemctl start docker > /dev/null 2>&1
    sudo systemctl enable docker > /dev/null 2>&1
    sudo groupadd docker > /dev/null 2>&1
    sudo usermod -aG docker $USER > /dev/null 2>&1
else
    echo -e  "\e[32mDocker is already installed. Skipping...\e[0m"
fi

# Install kubectl if not present
if ! command -v kubectl > /dev/null 2>&1; then
    echo -e "\e[34mInstalling kubectl...\e[0m"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo -e "\e[32mkubectl is already installed. Skipping...\e[0m"
fi

# Install K3D if not present
if ! command -v k3d >/dev/null 2>&1; then
    echo -e "\e[34mInstalling K3D...\e[0m"
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash > /dev/null 2>&1
else
    echo -e "\e[32mK3D is already installed. Skipping...\e[0m"
fi

# Install Helm if not present
if ! command -v helm >/dev/null 2>&1; then
    echo -e "\e[34mInstalling Helm...\e[0m"
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash > /dev/null 2>&1
else
    echo -e "\e[32mHelm is already installed. Skipping...\e[0m"
fi

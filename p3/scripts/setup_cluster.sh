#!/bin/bash

if ! command -v k3d > /dev/null 2>&1; then
    echo -e  "\e[34mk3d is not installed! Installing...\e[0m"
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash > /dev/null 2>&1
else
    echo "k3d is already installed. Skipping installation."
fi

echo -e "\e[34mCreating K3D cluster...\e[0m"
k3d cluster create mycluster > /dev/null 2>&1
echo -e "\e[32mCluster Created !\e[0m"

#!/bin/bash

# Function to uninstall Docker
remove_docker() {
    echo -e "\e[34mRemoving Docker...\e[0m"
    sudo apt-get remove --purge -y docker docker-engine docker.io containerd runc
    sudo apt-get autoremove -y
    sudo apt-get autoclean
    echo -e "\e[32mDocker has been removed.\e[0m"
}

# Function to uninstall kubectl
remove_kubectl() {
    echo -e "\e[34mRemoving kubectl...\e[0m"
    sudo apt-get remove --purge -y kubectl
    sudo apt-get autoremove -y
    sudo apt-get autoclean
    echo -e "\e[32mkubectl has been removed.\e[0m"
}

# Function to uninstall k3d
remove_k3d() {
    echo -e "\e[34mRemoving k3d...\e[0m"
    sudo rm -f /usr/local/bin/k3d
    echo -e "\e[32mk3d has been removed.\e[0m"
}

# Function to remove log files
remove_log_files() {
    echo -e "\e[34mRemoving .log files...\e[0m"
    find / -type f -name "*.log" -exec rm -f {} \;
    echo -e "\e[32mLog files have been removed.\e[0m"
}

# Main script execution
remove_docker
remove_kubectl
remove_k3d
remove_log_files

echo -e "\e[32mCleanup completed!\e[0m"


#!/bin/bash

echo -e "\e[31m🚨 WARNING: This will remove ALL Docker containers, images, volumes, and networks!\e[0m"
read -p "Are you sure you want to continue? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo -e "\e[31mAborted.\e[0m"
    exit 1
fi

# Stopping all containers
if [ "$(docker ps -aq)" ]; then
    echo -e "\e[34mStopping all containers...\e[0m"
    docker stop $(docker ps -aq) &>/dev/null
    echo -e "\e[32mAll containers are stopped.\e[0m"
else
    echo -e "\e[33mNo containers to stop.\e[0m"
fi

# Removing all containers
if [ "$(docker ps -aq)" ]; then
    echo -e "\e[34mRemoving all containers...\e[0m"
    docker rm $(docker ps -aq) &>/dev/null
    echo -e "\e[32mAll containers are removed.\e[0m"
else
    echo -e "\e[33mNo containers to remove.\e[0m"
fi

# Removing all images
if [ "$(docker images -q)" ]; then
    echo -e "\e[34mRemoving all images...\e[0m"
    docker rmi $(docker images -q) &>/dev/null
    echo -e "\e[32mAll images are removed.\e[0m"
else
    echo -e "\e[33mNo images to remove.\e[0m"
fi

# Removing all volumes
if [ "$(docker volume ls -q)" ]; then
    echo -e "\e[34mRemoving all volumes...\e[0m"
    docker volume rm $(docker volume ls -q) &>/dev/null
    echo -e "\e[32mAll volumes are removed.\e[0m"
else
    echo -e "\e[33mNo volumes to remove.\e[0m"
fi

# Removing all unused networks
echo -e "\e[34mRemoving all unused networks...\e[0m"
docker network prune -f &>/dev/null
echo -e "\e[32mAll unused networks are removed.\e[0m"

echo -e "\e[32m✅ Docker cleanup complete.\e[0m"


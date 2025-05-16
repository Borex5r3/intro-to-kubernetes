#!/bin/bash

# # Wait for the token to appear
while [ ! -f /vagrant/scripts/node-token.txt ]; do
  echo "Waiting for server token..."
  sleep 5
done

TOKEN=$(cat /vagrant/scripts/node-token.txt)



# # Join as agent
curl -sfL https://get.k3s.io | \
  K3S_URL="https://192.168.56.110:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="--node-ip=192.168.56.111" sh -

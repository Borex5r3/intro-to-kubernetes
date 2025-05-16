#!/bin/bash

# Install K3s as server
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110 --write-kubeconfig-mode 644" sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Export token to make it accessible to the worker node
while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
  echo "Waiting for node-token..."
  sleep 2
done
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/scripts/node-token.txt



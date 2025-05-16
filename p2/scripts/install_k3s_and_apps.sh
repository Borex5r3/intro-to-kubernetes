#!/bin/bash

# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110 --write-kubeconfig-mode 644" sh -


export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Wait for k3s to be ready
sleep 20

# Deploy Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/cloud/deploy.yaml

# Step 1 — Wait for controller to be ready
kubectl wait --namespace ingress-nginx --for=condition=Available deployment/ingress-nginx-controller --timeout=180s

# Step 2 — Wait for the webhook job to complete
echo "Waiting for the admission webhook job to finish..."
kubectl wait --for=condition=complete -n ingress-nginx job/ingress-nginx-admission-create --timeout=180s

# Step 3 — Wait for the endpoint to appear (optional safety)
echo "Waiting for admission webhook endpoint to become available..."
timeout 180 bash -c '
  until kubectl get endpoints ingress-nginx-controller-admission -n ingress-nginx | grep -q ":8443"; do
    echo "...still waiting..."
    sleep 5
  done
'


# Now apply everything else
kubectl apply -f /vagrant/manifests/

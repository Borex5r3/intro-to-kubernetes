#!/bin/bash

source env.sh

# Create a namespace for ArgoCD
echo -e "\e[34mCreating ArgoCD namespace...\e[0m"
kubectl create namespace argocd

# Install ArgoCD 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null 2>&1

# Wait for ArgoCD pods to start
echo -e "\e[34mWaiting for ArgoCD pods to start...\e[0m"
kubectl -n argocd rollout status deployment/argocd-server > /dev/null 2>&1

# Config the argocd application
kubectl apply -f $ARGO_CONF_PATH/app.yaml > /dev/null 2>&1

# Expose ArgoCD UI for local access (port-forwarding)
echo -e "\e[34mSetting up port-forwarding to access ArgoCD UI locally...\e[0m"
nohup kubectl -n argocd port-forward svc/argocd-server 8282:443 > nohup_argocd.log 2>&1 &

echo -e "\e[32mArgoCD is forwarded to https://localhost:8282 .\e[0m"

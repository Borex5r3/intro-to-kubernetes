#!/bin/bash

# Create a namespace for ArgoCD
echo -e "\e[34mCreating ArgoCD namespace...\e[0m"
kubectl create namespace argocd

# Install ArgoCD 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null 2>&1

# Wait for ArgoCD pods to start
echo -e "\e[34mWaiting for ArgoCD pods to start...\e[0m"
kubectl -n argocd rollout status deployment/argocd-server > /dev/null 2>&1

# Config the argocd application
# kubectl apply -f ../confs/app.yaml > /dev/null 2>&1

echo -e "\e[34mApplying ArgoCD application configuration...\e[0m"

kubectl apply -f ../confs/app.yaml > /dev/null 2>&1

echo -e "\e[32mApplication configuration applied successfully.\e[0m"


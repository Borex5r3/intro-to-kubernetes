#!/bin/bash

# Expose ArgoCD UI for local access (port-forwarding)
echo -e "\e[34mSetting up port-forwarding to access ArgoCD UI locally...\e[0m"

nohup kubectl -n argocd port-forward svc/argocd-server 8282:443 > nohup_argocd.log 2>&1 &

echo -e "\e[32mArgoCD is forwarded to https://localhost:8282 .\e[0m"


# Expose app for local access (port-forwarding)
echo -e "\e[34mSetting up port-forwarding to access the app locally...\e[0m"

nohup kubectl port-forward svc/will-app-service -n dev 8888:8888 > nohup_app.log 2>&1 &

echo -e "\e[32mThe app is forwarded to https://localhost:8888 .\e[0m"

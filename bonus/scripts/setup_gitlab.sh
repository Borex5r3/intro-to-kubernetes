#!/bin/bash


if ! command -v helm >/dev/null 2>&1; then
    echo -e "\e[31mHelm is not installed! Exiting.\e[0m"
    exit 1
fi

if ! command -v kubectl >/dev/null 2>&1; then
    echo -e "\e[31mkubectl is not installed or not configecho_stepured properly! Exiting.\e[0m"
    exit 1
fi

echo -e "\e[34mAdding GitLab Helm repository...\e[0m"
helm repo add gitlab https://charts.gitlab.io > /dev/null 2>&1
helm repo update > /dev/null 2>&1

echo -e "\e[34mCreating GitLab namespace...\e[0m"
kubectl create namespace gitlab > /dev/null 2>&1

echo -e "\e[34mDeploying GitLab with Helm...\e[0m"
helm upgrade --install gitlab gitlab/gitlab \
  --set global.hosts.https=false \
  --set global.hosts.domain=adbaich.com \
  --set global.hosts.externalIP=localhost \
  --set certmanager-issuer.email=me@example.com \
  --set gitlab.gitlab-runner.enabled=false \
  --namespace gitlab > /dev/null 2>&1

# Wait for the service to have endpoints
echo -e "\e[34mWaiting for service gitlab-webservice-default to be ready...\e[0m"
kubectl wait --for=condition=Ready pod -l app=webservice -n gitlab --timeout=500s > /dev/null 2>&1

# Change service type to NodePort
kubectl patch service gitlab-webservice-default -n gitlab -p '{"spec": {"type": "NodePort"}}' > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo -e "\e[34mService gitlab-webservice-default is ready. Starting port-forwarding...\e[0m"

  # Start port-forwarding in the background
  nohup kubectl port-forward svc/gitlab-webservice-default 8888:8181 -n gitlab > /dev/null 2>&1 &

  echo -e "\e[32mPort-forwarding for gitlab started on http://localhost:8888/\e[0m"

else
  echo "\e[31mTimed out waiting for service gitlab-webservice-default to be ready.\e[0m"
  exit 1
fi

#!/bin/bash

source env.sh

# YAML content with placeholder for IP
YAML_CONTENT=$(cat <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: wilapp
  namespace: argocd
spec:
  project: default
  source:
    repoURL: http://NODE_IP:POD_PORT/root/$PROJECT_NAME.git
    targetRevision: HEAD
    path: .
  destination:
    server: https://kubernetes.default.svc
    namespace: dev
  syncPolicy:
    syncOptions:
    - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
EOF
)

# Replace the placeholder NODE_IP with the actual Node IP
YAML_CONTENT=$(echo "$YAML_CONTENT" | sed "s/NODE_IP/$NODE_IP/g")


# Replace the placeholder POD_PORT with the actual Pod Port
YAML_CONTENT=$(echo "$YAML_CONTENT" | sed "s/POD_PORT/$POD_PORT/g")

# Write the updated YAML to the file
echo "$YAML_CONTENT" > "$ARGO_CONF_PATH/app.yaml"

echo "YAML file '$ARGO_CONF_PATH/app.yaml' created with repoURL 'http://$NODE_IP:$POD_PORT/root/$PROJECT_NAME.git' ."

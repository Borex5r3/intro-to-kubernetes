#!/bin/bash

get_and_print_secret() {
  local namespace=$1
  local secret_name=$2

  echo "Retrieving secret ${secret_name} from namespace ${namespace}..."

  secret_value=$(kubectl get secret -n "${namespace}" "${secret_name}" -o jsonpath="{.data.password}" | base64 --decode)

  if [ -z "${secret_value}" ]; then
    echo "Error: Secret ${secret_name} or key password not found."
  else
    echo -e "Credentials for ${namespace} :\nUsername : admin\nPassword : ${secret_value}\n"
  fi
}

echo -e "\n==== ArgoCD Admin Password ===="
get_and_print_secret "argocd" "argocd-initial-admin-secret"

echo -e '\e[32mCredentials found successfully.\n\e[0m'

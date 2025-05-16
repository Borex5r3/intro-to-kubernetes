#!/bin/bash

export COMMIT_MESSAGE="Add confs/app directory"
export SOURCE_DIR="adbaich"
export NODE_IP="$(kubectl get nodes -o jsonpath={'.items[*].status.addresses[?(@.type=="InternalIP")].address'})"
export POD_PORT="$(kubectl get svc -n gitlab gitlab-webservice-default -o jsonpath={'.spec.ports[?(@.port==8181)].nodePort'})"
export ARGO_CONF_PATH="../confs"
export PROJECT_NAME="app"

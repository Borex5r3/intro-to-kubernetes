#!/bin/bash

# Expose app for local access (port-forwarding)
echo -e "\e[34mSetting up port-forwarding to access the app locally...\e[0m"

nohup kubectl port-forward svc/will-app-service -n dev 8383:8888 > nohup_app.log 2>&1 &

echo -e "\e[32mThe app is forwarded to https://localhost:8383 .\e[0m"

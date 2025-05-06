#!/bin/bash

./setup.sh
./setup_cluster.sh
./setup_gitlab.sh

echo -e "\e[33mNext steps :\n\e[0m"
echo -e "\e[32m1.\e[0m Run the \e[36mget_secrets.sh\e[0m script to retrieve the GitLab and ArgoCD passwords.\e[0m"
echo -e "\e[32m2.\e[0m Go to \e[36mhttp://localhost:8888/-/user_settings/personal_access_tokens\e[0m and create a personal access token.\e[0m"
echo -e "\e[32m3.\e[0m Create a \e[36mproject\e[0m in gitlab."
echo -e "\e[32m4.\e[0m Update the \e[36mPROJECT_NAME\e[0m variable in the \e[36menv.sh\e[0m file."
echo -e "\e[32m5.\e[0m Update the \e[36mGitLab_ACCESS_TOKEN\e[0m variable in the \e[36menv.sh\e[0m file."
echo -e "\e[32m6.\e[0m Update the \e[36mSOURCE_DIR\e[0m variable in the \e[36menv.sh\e[0m file."
echo -e "\e[32m7.\e[0m Update the \e[36mCOMMIT_MESSAGE\e[0m variable in the \e[36menv.sh\e[0m file.\n"

read -p "$(echo -e "\e[33mOnce you have completed all the steps above, press ENTER to continue...\e[0m")"

./push_app.sh
./generate_argo_conf.sh
./setup_argocd.sh


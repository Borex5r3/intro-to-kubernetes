#!/bin/bash

source env.sh

GITLAB_REPO_URL="http://oauth2:$GitLab_ACCESS_TOKEN@localhost:8888/root/$PROJECT_NAME.git"
TEMP_DIR=$(mktemp -d)
REPO_NAME=$(basename "$GITLAB_REPO_URL" .git)

# Clone the repository
echo -e "\e[34mCloning repository...\e[0m"
git clone "$GITLAB_REPO_URL" "$TEMP_DIR/$REPO_NAME" > /dev/null 2>&1

# Check if clone was successful
if [ $? -ne 0 ]; then
  echo "\e[31mFailed to clone the repository. Please check the URL and access token.\e[0m"
  exit 1
fi

# Copy the source directory into the repository
echo -e "\e[34mCopying $SOURCE_DIR to the repository...\e[0m"
cp "$SOURCE_DIR/deployment.yaml" "$TEMP_DIR/$REPO_NAME" > /dev/null 2>&1
cp "$SOURCE_DIR/service.yaml" "$TEMP_DIR/$REPO_NAME" > /dev/null 2>&1

# Move into the cloned repository
cd "$TEMP_DIR/$REPO_NAME" > /dev/null 2>&1

# Add the changes
git add .

# Commit the changes
echo -e "\e[34mCommitting changes...\e[0m"
git commit -m "$COMMIT_MESSAGE" > /dev/null 2>&1

# Push the changes
echo -e "\e[34mPushing changes to the repository...\e[0m"
git push > /dev/null 2>&1

# Check if push was successful
if [ $? -eq 0 ]; then
  echo -e '\e[32mChanges pushed successfully!\e[0m'
else
  echo -e "\e[31mFailed to push changes. Please check your permissions and network connection.\e[0m"
  exit 1
fi

# Clean up
echo -e "\e[34mCleaning up...\e[0m"
cd - > /dev/null 2>&1
rm -rf "$TEMP_DIR" > /dev/null 2>&1

echo "Done!"


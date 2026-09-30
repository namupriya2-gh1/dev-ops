#!/bin/bash

# Configuration
API_URL="https://github.com"
USERNAME=$username
TOKEN=$token

# Inputs
REPO_OWNER=$1
REPO_NAME=$2

# Input Validation
if [ -z "$REPO_OWNER" ] || [ -z "$REPO_NAME" ]; then
    echo "ERROR: Missing arguments!"
    echo "Usage: ./list_users.sh namupriya2-gh1 dev-ops"
    exit 1
fi

# API Function
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Main Execution
function list_users_with_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    
    # Run the API call
    response=$(github_api_get "$endpoint")
    
    # Extract logins using jq
    collaborators=$(echo "$response" | jq -r '.[] | .login' 2>/dev/null)
    
    if [ -z "$collaborators" ] || [ "$collaborators" = "null" ]; then
        echo "No outside collaborators found or access denied for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "The following users have access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

list_users_with_access

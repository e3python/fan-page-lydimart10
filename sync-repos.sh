#!/bin/bash

# Script to clone repos, set upstream, pull/rebase, and push changes
TEMPLATE_REPO="git@github.com-e3civichigh:e3python/fan-page.git"
BASE_DIR="/tmp/fan-page-repos"
MODULES=(2 3 5)

# Create base directory
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

for MOD in "${MODULES[@]}"; do
    REPO_NAME="e3-web-design-mod${MOD}-fan-page-fan-page"
    REPO_URL="git@github.com-e3civichigh:e3python/${REPO_NAME}.git"
    
    echo "======================================"
    echo "Processing: $REPO_NAME"
    echo "======================================"
    
    # Clone the repo
    echo "Cloning $REPO_URL..."
    git clone "$REPO_URL"
    cd "$REPO_NAME"
    
    # Set upstream to the template repo
    echo "Setting upstream to $TEMPLATE_REPO..."
    git remote add upstream "$TEMPLATE_REPO"
    
    # Pull and rebase from upstream
    echo "Pulling and rebasing from upstream..."
    git pull --rebase upstream main
    
    # Remove upstream
    echo "Removing upstream remote..."
    git remote remove upstream
    
    # Push changes (force push to handle rebased commits)
    echo "Pushing changes..."
    git push --force-with-lease origin main
    
    echo "✓ Completed: $REPO_NAME"
    echo ""
    
    # Go back to base directory
    cd "$BASE_DIR"
done

echo "======================================"
echo "All repos processed successfully!"
echo "======================================"

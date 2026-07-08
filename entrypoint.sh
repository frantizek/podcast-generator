#!/bin/bash
set -euo pipefail

echo "=================================="
echo "Podcast Generator"
echo "=================================="

git config --global user.name "${INPUT_NAME}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

echo "Running feed generator..."
python3 /app/feed.py

echo "Checking for changes..."

git add -A

if git diff --staged --quiet; then
    echo "No changes detected."
    exit 0
fi

echo "Changes detected. Creating commit..."

git commit -m "Update podcast feed [skip ci]"

echo "Pushing changes..."
git push

echo "Done."
echo "=================================="
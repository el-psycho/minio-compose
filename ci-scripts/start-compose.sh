#!/bin/bash
set -euo pipefail

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")
repo_path="$script_dir/.."

cd "$repo_path" || { echo "Could not cd into $repo_path" >&2; exit 1; }

CREDS_JSON=$(vault kv get --format=json minio/admin-creds)
MINIO_ACCESS_KEY=$(echo "$CREDS_JSON" | jq -r '.data.data["MINIO_ACCESS_KEY"]')
MINIO_SECRET_KEY=$(echo "$CREDS_JSON" | jq -r '.data.data["MINIO_SECRET_KEY"]')

export MINIO_ACCESS_KEY
export MINIO_SECRET_KEY

# Also applies any compose changes to running services
docker-compose up -d


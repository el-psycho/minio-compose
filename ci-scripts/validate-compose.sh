#!/bin/bash
set -euo pipefail

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")
repo_path="$script_dir/.."

cd "$repo_path" || { echo "Could not cd into $repo_path" >&2; exit 1; }

docker-compose config -q && echo "Compose validation passed"


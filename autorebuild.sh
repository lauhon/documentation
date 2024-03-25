#!/bin/bash

script_dir=$(cd "$(dirname "$0")" && pwd)
current_dir=$(pwd)
if [ "$script_dir" != "$current_dir" ]; then
    echo "This script must be run from the Documentation repo root"
    exit 1
fi

rebuild() {
    echo "Rebuilding Website"
    pushd websites/docs.temporal.io > /dev/null 2>&1
    yarn && yarn build > /dev/null 2>&1
    popd > /dev/null 2>&1
}

old_status=$(git status --porcelain "./docs-src")
while true; do
    status=$(git status --porcelain "./docs-src")
    if [[ -n "$status" && "$old_status" != "$status" ]]; then rebuild; fi
    old_status=$status
    sleep 180
done

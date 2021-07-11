#!/usr/bin/env bash

join_path() {
    if [[ ":${PATH}:" != *":${1}:"* ]]; then
        export PATH="${PATH}:${1}"
    fi
}

PATH_LIST=(
    "${HOME}/.local/bin"
    "${HOME}/storage/development/flutter/bin"
    "${HOME}/.node_modules/bin"
)

for item in "${PATH_LIST[@]}"; do
    join_path "${item}"
done

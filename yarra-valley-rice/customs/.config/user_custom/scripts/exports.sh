#!/usr/bin/env bash

SCRIPTS="${USER_CUSTOM}/scripts"
COLORS="${SCRIPTS}/colors.sh"

source_file() {
    if [[ -f "${1}" ]]; then
        # shellcheck disable=SC1090
        source "${1}"
    fi
}

source_file "${COLORS}"
SOURCES_LIST=(
    "${SCRIPTS}/alias.sh"
    "${SCRIPTS}/change_prompt.sh"
    "${SCRIPTS}/fzf.sh"
    "${SCRIPTS}/paths.sh"
    "${SCRIPTS}/proxy.sh"
    "${SCRIPTS}/variables.sh"
    "${SCRIPTS}/clouds.sh"
)

for item in "${SOURCES_LIST[@]}"; do
    source_file "${item}"
done

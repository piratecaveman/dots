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

DROPIN_DIR="${SCRIPTS}/sources"

if [[ -d "${DROPIN_DIR}" ]]; then
    while IFS= read -r -d '' item; do
        source_file "${item}"
    done < <(fd . --absolute-path --hidden --type f --extension sh --min-depth 1 --max-depth 1 "${DROPIN_DIR}" -0)
fi

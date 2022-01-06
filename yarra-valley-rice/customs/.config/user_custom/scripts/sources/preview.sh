#!/usr/bin/env bash

preview() {
    local folder
    if [[ -z "${1}" ]]; then
        folder="${PWD}"
    else
        folder="${1}"
    fi

    local images
    images="$(
        fd . \
            --min-depth 1 \
            --max-depth 1 \
            --type f \
            --extension jpg \
            --extension jpeg \
            --extension png \
            --extension webp \
            --absolute-path \
            "${folder}"
    )"

    echo "${images}" | fzf --preview 'ueberzug layer --parser json \{"action": "add", "x": 0, "y": 0, "path": "{}"\}'

}

ueberzug_create() {
    declare -x fifo
    fifo="$(mktmp --dry-run --suffix "ueberdunk")"
    declare -x prev_id
    prev_id="fzfpreview"
    readonly bash_bin="$(which bash)"
    local script_path
    script_path="$(realpath "${0}")"
}

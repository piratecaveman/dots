#!/usr/bin/env bash

COLOR_UNDERLINE="$(tput sgr 0 1)"
COLOR_BOLD="$(tput bold)"
COLOR_RED="$(tput setaf 1)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_YELLOW="$(tput setaf 3)"
COLOR_BLUE="$(tput setaf 4)"
COLOR_VIOLET="$(tput setaf 5)"
COLOR_AQUA="$(tput setaf 6)"
COLOR_WHITE="$(tput setaf 7)"
COLOR_RESET="$(tput sgr0)"

wrap_color() {

    if [[ -z "${1}" ]]; then
        printf "Usage: wrap_color [COLOR_NAME] [TEXT]\n"
        return
    fi

    if [[ -z "${2}" ]]; then
        printf "Usage: wrap_color [COLOR_NAME] [TEXT]\n"
        return
    fi

    local wrapper
    case "${1}" in
    'underline')
        wrapper="${COLOR_UNDERLINE}"
        ;;
    'bold')
        wrapper="${COLOR_BOLD}"
        ;;
    'red')
        wrapper="${COLOR_RED}"
        ;;
    'green')
        wrapper="${COLOR_GREEN}"
        ;;
    'yellow')
        wrapper="${COLOR_YELLOW}"
        ;;
    'blue')
        wrapper="${COLOR_BLUE}"
        ;;
    'violet')
        wrapper="${COLOR_VIOLET}"
        ;;
    'aqua')
        wrapper="${COLOR_AQUA}"
        ;;
    'white')
        wrapper="${COLOR_WHITE}"
        ;;
    *)
        wrapper="${COLOR_RESET}"
        ;;
    esac
    echo "${wrapper}${2}${COLOR_RESET}"
}

if [[ -z "${OUTPUT_DIR}" ]]; then
    OUTPUT_DIR="${PWD}"
fi

printf "Using output dir: %s\n" "$(wrap_color 'blue' "${OUTPUT_DIR}")"

if [[ ! -d "${OUTPUT_DIR}" ]]; then
    printf "%s\n\t%s\n\tDir does not exist\n" \
        "$(wrap_color 'yellow' "WARNING")" \
        "$(wrap_color 'blue' "${OUTPUT_DIR}")"
    mkdir -p "${OUTPUT_DIR}"
fi

CONFIG_DIR="${HOME}/.secrets/rclone"
CONFIG_EXT="conf"
REMOTES=(
    "box"
    "disroot"
    "dropbox"
    "gdrive"
    "hubic"
    "koofr"
    "mega"
    "nextcloud"
    "onedrive"
    "pcloud"
    "yandex"
)

get_path() {
    if [[ -z "$1" ]]; then
        printf "%s %s [REMOTE_NAME]\n" \
            "$(wrap_color 'red' 'Usage:')" \
            "$(wrap_color 'yellow' 'get_path')"
        return
    fi
    local path
    path="${CONFIG_DIR}/${1}.${CONFIG_EXT}"
    echo "${path}"
}

get_remotes() {
    local remotes
    remotes=$(rclone --config "${1}" listremotes)
    echo "${remotes}"
}

get_listing() {
    if [[ -z "$1" ]]; then
        printf "%s %s [REMOTE_NAME]\n" \
            "$(wrap_color 'red' 'Usage:')" \
            "$(wrap_color 'yellow' 'get_listing')"
        return
    fi
    local path
    path=$(get_path "${1}")
    local remotes
    readarray -t remotes < <(get_remotes "${path}")
    for item in "${remotes[@]}"; do
        printf "\t\tGetting listing for %s\n" "$(wrap_color 'violet' "${item%:}")"
        printf "\t\tThis may take a while; please be patient ...\n"
        /usr/bin/rclone --config "${path}" lsd -R "${item}" >"${OUTPUT_DIR}/${item%:}.txt"
        printf "\t\tListing complete for %s\n" \
            "$(wrap_color 'bold' "$(wrap_color 'aqua' "${item%:}")")"
    done
}

if [[ -z "${1}" ]]; then
    for host in "${REMOTES[@]}"; do
        printf "\n\tGetting Listing for host %s\n" "$(wrap_color "green" "${host}")"
        get_listing "${host}"
        printf "\tListing completed for host %s\n\n" "$(wrap_color "green" "${host}")"
    done
else
    printf "Getting listing for host %s\n" "$(wrap_color "green" "${1}")"
    get_listing "${1}"
    printf "Listing completed for host %s\n" "$(wrap_color "green" "${1}")"
fi

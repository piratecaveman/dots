#!/usr/bin/env bash

base_folder="/media/ntfs/home/leshen"
encrypted_den="${base_folder}/rustic-den"

PROFILES=(
    'yandex-piratecaveman'
    'onedrive-piratecaveman'
    'dropbox-piratecaveman'
)

rclone_config_get() {
    local config_home
    config_home="${HOME}/.secrets/rclone"
    local config

    case "${1}" in
    'box')
        config="${config_home}/box.conf"
        ;;
    'dropbox')
        config="${config_home}/dropbox.conf"
        ;;
    'distoot')
        config="${config_home}/distoot.conf"
        ;;
    'gdrive')
        config="${config_home}/gdrive.conf"
        ;;
    'hubic')
        config="${config_home}/hubic.conf"
        ;;
    'koofr')
        config="${config_home}/koofr.conf"
        ;;
    'mega')
        config="${config_home}/mega.conf"
        ;;
    'nextcloud')
        config="${config_home}/nextcloud.conf"
        ;;
    'onedrive')
        config="${config_home}/onedrive.conf"
        ;;
    'pcloud')
        config="${config_home}/pcloud.conf"
        ;;
    'yandex')
        config="${config_home}/yandex.conf"
        ;;
    *)
        echo "Cloud not found"
        exit 1
        ;;
    esac
    echo "${config}"
}

get_accounts_for_config() {
    local result
    result="$(rclone --config "${1}" listremotes)"
    echo "${result}"
}

upload_to_cloud() {
    local source
    source="${1}"
    local destination
    destination="${2}"

    local config
    config="$(rclone_config_get "$(echo "${destination}" | cut -f1 -d'-')")"

    if [[ "${config}" == "Cloud not found" ]]; then
        echo "Config not found: $(echo "${destination}" | cut -f1 -d':'):"
        exit 1
    fi
    bat "${config}"

    # read -a remotes <<< "$(get_accounts_for_config "${config}")"
}

upload_to_cloud "whatverr" "ybandex-kj1594-protonmail:dens/Various Files/"

#!/usr/bin/env bash

BASEPATH="/media/ntfs/home/leshen"
DEN="${BASEPATH}/rustic-den"

PROFILES=(
    "yandex-piratecaveman"
    "onedrive-piratecaveman"
    "dropbox-piratecaveman"
)

get_rclone_config() {
    local config_home
    config_home="${HOME}/.secrets/rclone"
    local config_path

    case "${1}" in
    'box')
        config_path="${config_home}/box.conf"
        ;;
    'dropbox')
        config_path="${config_home}/dropbox.conf"
        ;;
    'distoot')
        config_path="${config_home}/distoot.conf"
        ;;
    'gdrive')
        config_path="${config_home}/gdrive.conf"
        ;;
    'hubic')
        config_path="${config_home}/hubic.conf"
        ;;
    'koofr')
        config_path="${config_home}/koofr.conf"
        ;;
    'mega')
        config_path="${config_home}/mega.conf"
        ;;
    'nextcloud')
        config_path="${config_home}/nextcloud.conf"
        ;;
    'onedrive')
        config_path="${config_home}/onedrive.conf"
        ;;
    'pcloud')
        config_path="${config_home}/pcloud.conf"
        ;;
    'yandex')
        config_path="${config_home}/yandex.conf"
        ;;
    *)
        echo "Cloud not found"
        exit 1
        ;;
    esac
    echo "${config_path}"
}

upload_to_cloud() {
    local source
    source="${1}"
    local config

    for cloud in "${PROFILES[@]}"; do
        echo "${cloud}:"
        config="$(get_rclone_config "$(echo "${cloud}" | cut -f1 -d'-')")"
        result="$(/usr/bin/rclone --config="${config}" --transfers=16 copy "${source}/" "${cloud}:dens/")"
        echo "${result}"
    done
}

upload_to_cloud "${DEN}"
/usr/bin/touch /tmp/secrets-upload.timestamp

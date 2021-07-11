#!/usr/bin/env bash

SCRIPTS="${USER_CUSTOM}/scripts"
COLORS="${SCRIPTS}/colors.sh"

if [[ -f "${COLORS}" ]]; then
    # shellcheck disable=SC1090
    source "${COLORS}"
fi

drive="onedrive-nonionite:onion-secrets"
local="/media/ntfs/home/leshen/dens/onion-den/"

get_onion() {
    echo "${COLOR_BLUE}Getting your onions ...${COLOR_RESET}"
    /usr/bin/rclone sync -P "${drive}" "${local}"
}

send_onion() {
    echo "${COLOR_GREEN}Sending your onions ...${COLOR_RESET}"
    /usr/bin/rclone sync -P "${local}" "${drive}"
}

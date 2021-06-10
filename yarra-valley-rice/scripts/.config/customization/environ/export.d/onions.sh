#!/usr/bin/env bash

drive="onedrive-nonionite:onion-secrets"
local="/media/ntfs/home/leshen/dens/onion-den/"

get_onion() {
    /usr/bin/rclone sync -P "${drive}" "${local}"
}

send_onion() {
    /usr/bin/rclone sync -P "${local}" "${drive}"
}


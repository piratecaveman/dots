#!/usr/bin/env bash

home="/media/ntfs/home/leshen"
cloud="${home}/dens/cloud"
library="${cloud}/calibre-library"

cloud_box="box-nonionite:"
cloud_dropbox="dropbox-nonionite:"
cloud_onedrive="onedrive-nonionite:"

destination="books/library/"

run_rc() {
    /usr/bin/rclone --transfers=8 sync -P "${1}" "${cloud_box}${2}"
    /usr/bin/rclone --transfers=8 sync -P "${1}" "${cloud_dropbox}${2}"
    /usr/bin/rclone --transfers=8 sync -P "${1}" "${cloud_onedrive}${2}"
}

run_rc "${library}" "${destination}"

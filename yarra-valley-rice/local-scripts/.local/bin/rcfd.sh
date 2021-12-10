#!/usr/bin/env bash

RC_LIST_PATH="/media/ntfs/shared/jdownloader/smut/rclone-lists"
OLDER_DIR="${PWD}"

if [[ -z "${1}" ]]; then
    echo "Usage: rcfd.sh [SOMETHING]"
fi

cd "${RC_LIST_PATH}" || exit
rg -i "${1}" -- *.txt
cd "${OLDER_DIR}" || exit

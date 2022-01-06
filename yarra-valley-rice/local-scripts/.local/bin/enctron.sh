#!/usr/bin/env bash

ENCTRON_PATH="${HOME}/.local/bin/enctron"
BASEPATH="/media/ntfs/home/leshen"
DENS="${BASEPATH}/dens"
GRIZZLY="${DENS}/grizzly-den"
CLOUD="${DENS}/cloud"
# WOLF="${DENS}/wolf-den"
# ONION="${DENS}/onion-den"

BLACKLIST=(
    "${GRIZZLY}/kdbx-vaults"
    "${GRIZZLY}/keys"
    "${CLOUD}"
)
PASSPHRASE_FILE="${HOME}/.secrets/pass.txt"
SIGNER="649A18F8B214CC3B9FFBAAEED91682139651239F"
RECIPIENTS=(
    "649A18F8B214CC3B9FFBAAEED91682139651239F"
    "3DE51F09E743D61612ED88FEE284414DE69F863A"
    "7099EEC6189503176CC2CF2F26D11DE2066F6DB4"
    "3F5CDC5F9728FC8E5A287021544F67000295AA3B"
)

create_blacklist() {
    local string
    for item in "${BLACKLIST[@]}"; do
        string="${string} --blacklist ${item}"
    done
    echo "${string}"
}

create_recipients() {
    local string
    for item in "${RECIPIENTS[@]}"; do
        string="${string} --recipient ${item}"
    done
    echo "${string}"
}

blacklisted_paths="$(create_blacklist)"
recipients="$(create_recipients)"

# shellcheck disable=SC2086
"$(
    "${ENCTRON_PATH}" --copy-blacklisted \
        ${blacklisted_paths} \
        --extension asc \
        --input "${DENS}" \
        --output "${BASEPATH}/rustic-den" \
        --passphrase-file "${PASSPHRASE_FILE}" \
        --signer "${SIGNER}" \
        ${recipients}
)"

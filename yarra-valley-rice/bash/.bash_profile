#!/usr/bin/env bash
#
# ~/.bash_profile
#

source_file() {
	if [[ -f "${1}" ]]; then
		# shellcheck disable=1090
		source "${1}"
	fi
}

USER_CUSTOM="${HOME}/.config/user_custom"
SCRIPTS="${USER_CUSTOM}/scripts"

SOURCES_LIST=(
	"${SCRIPTS}/exports.sh"
	"${HOME}/.bashrc"
)

for item in "${SOURCES_LIST[@]}"; do
	source_file "${item}"
done

setproxy

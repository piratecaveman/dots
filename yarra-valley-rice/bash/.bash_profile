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

environ="${HOME}/.config/customization/environ"

SOURCES_LIST=(
	"${environ}/export.d/export.sh"
	"${environ}/alias.d/alias.sh"
	"${environ}/export.d/proxy.sh"
	"${HOME}/.bashrc"
)

for i in "${SOURCES_LIST[@]}"; do
	source_file "${i}"
done

setproxy

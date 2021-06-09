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

SOURCES_LIST=(
	"${HOME}/.config/customization/environ/export.d/export.sh"
	"${HOME}/.config/customization/environ/alias.d/alias.sh"
	"${HOME}/.config/customization/environ/export.d/proxy.sh"
	"${HOME}/.bashrc"
)

for i in "${SOURCES_LIST[@]}"; do
	source_file "${i}"
done

setproxy

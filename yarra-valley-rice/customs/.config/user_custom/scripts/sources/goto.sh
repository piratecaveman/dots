#!/usr/bin/env bash

goto() {
	usage() {
		echo "goto [START_DIR]"
		exit 1
	}

	local start_dir
	start_dir="${PWD}"

	if [[ -n "${1}" ]]; then
		if [[ ! -d "${1}" ]]; then
			usage
		fi
		start_dir="${1}"
	fi

	local selected_dir
	selected_dir="$(fd . --type d --hidden "${start_dir}" | fzf)"
	cd "${selected_dir}" || exit
}

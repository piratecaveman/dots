#!/usr/bin/env bash

scroll() {

	usage() {
		echo "Usage: scroll [PATH]"
		exit 1
	}

	local path
	path="${PWD}"

	if [[ -n "${1}" ]]; then
		if [[ ! -d "${1}" ]]; then
			usage
		fi
		path="${1}"
	fi

	fd . --type f "${path}" | fzf --preview 'bat --line-range :500 --color=always {}'
}

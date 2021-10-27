#!/usr/bin/env bash

border_status=$(bspc config border_width)
width="${1}"

if [[ -z "${1}" ]]; then
	width=5
fi

if [[ "${border_status}" -gt 0 ]]; then
	bspc config border_width 0
elif [[ "${border_status}" -eq 0 ]]; then
	bspc config border_width "${width}"
fi

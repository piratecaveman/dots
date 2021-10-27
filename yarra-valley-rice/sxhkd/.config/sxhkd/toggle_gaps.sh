#!/usr/bin/env bash

current_gap=$(bspc config window_gap)
gap_size=$1

if [[ -z "${1}" ]]; then
    gap_size=5
fi

if [[ "${current_gap}" -gt 0 ]]; then
    bspc config window_gap 0
elif [[ "${current_gap}" -eq 0 ]]; then
    bspc config window_gap "${gap_size}"
fi

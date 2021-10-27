#!/usr/bin/env bash

# colors
# UNDERLINE="$(tput sgr 0 1)"
# BOLD="$(tput bold)"
# RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
# YELLOW="$(tput setaf 3)"
# BLUE="$(tput setaf 4)"
# VIOLET="$(tput setaf 5)"
AQUA="$(tput setaf 6)"
# WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

LQCONVERTER="/home/wraith/.local/bin/lqconverter.sh"

quality="${1}"
if [[ -z "${quality}" ]]; then
    quality=60
fi

sample_size="${2}"
if [[ -z "${sample_size}" ]]; then
    sample_size=5
fi

while IFS= read -r -d '' item; do
    printf "\t${GREEN}Compressing: ${AQUA}%s${RESET}\n" "${item}"
    cd "${item}" || exit
    "${LQCONVERTER}" "${quality}" "${sample_size}"
    cd ..
    echo
done < <(fd --absolute-path --max-depth 1 --min-depth 1 --type d -0)
echo

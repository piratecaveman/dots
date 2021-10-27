#!/usr/bin/env bash

# colors
# UNDERLINE="$(tput sgr 0 1)"
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
# BLUE="$(tput setaf 4)"
VIOLET="$(tput setaf 5)"
AQUA="$(tput setaf 6)"
# WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

DETECTION_SCRIPT="${HOME}/.local/bin/detect-quality.py"

function converter_covert() {
    quality="${1}"
    fd --absolute-path --max-depth 1 --type f -e jpg -e jpeg -e png -e webp | parallel -j 8 mogrify -quality "${quality}" {}
}

# get quality if required
quality="${1}"
if [[ -z "${quality}" ]]; then
    quality=60
fi

# sample size to detect quality, default: 5
sample_size="${2}"
if [[ -z "${sample_size}" ]]; then
    sample_size=5
fi

printf "\t${GREEN}Setting Quality: ${AQUA}%s${RESET}\n" "${quality}"
initial_size=$(du -hs | cut -f1)

# detecting quality
current_quality="$(${DETECTION_SCRIPT} -d "${PWD}" -s "${sample_size}")"
printf "\t${GREEN}Quality Detected: ${AQUA}%s${RESET}\n" "${current_quality}"
if [[ "$current_quality" -gt "$quality" ]]; then
    printf "\tConverting files; this might take a while ...\n"
    # actual conversion
    converter_covert "${quality}"
else
    printf "\tThe files %s%scannot be compressed%s further at this quality\n" "${VIOLET}" "${BOLD}" "${RESET}"
fi

final_size=$(du -hs | cut -f1)
printf "\t${BOLD}${YELLOW}Initial Size: ${RED}%s${RESET}\n" "${initial_size}"
printf "\t${BOLD}${GREEN}Final Size: ${AQUA}%s${RESET}\n" "${final_size}"

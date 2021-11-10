#!/usr/bin/env bash

# colors
COLOR_UNDERLINE="$(tput sgr 0 1)"
COLOR_BOLD="$(tput bold)"
COLOR_RED="$(tput setaf 1)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_YELLOW="$(tput setaf 3)"
COLOR_BLUE="$(tput setaf 4)"
COLOR_VIOLET="$(tput setaf 5)"
COLOR_AQUA="$(tput setaf 6)"
COLOR_WHITE="$(tput setaf 7)"
COLOR_RESET="$(tput sgr0)"

wrap_color() {
    local wrapper
    case "${1}" in
    'underline')
        wrapper="${COLOR_UNDERLINE}"
        ;;
    'bold')
        wrapper="${COLOR_BOLD}"
        ;;
    'red')
        wrapper="${COLOR_RED}"
        ;;
    'green')
        wrapper="${COLOR_GREEN}"
        ;;
    'yellow')
        wrapper="${COLOR_YELLOW}"
        ;;
    'blue')
        wrapper="${COLOR_BLUE}"
        ;;
    'violet')
        wrapper="${COLOR_VIOLET}"
        ;;
    'aqua')
        wrapper="${COLOR_AQUA}"
        ;;
    'white')
        wrapper="${COLOR_WHITE}"
        ;;
    *)
        wrapper="${COLOR_RESET}"
        ;;
    esac
    echo "${wrapper}${2}${COLOR_RESET}"
}

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

printf "\t%s%s\n" \
    "$(wrap_color 'green' "Setting Quality: ")" \
    "$(wrap_color 'aqua' "${quality}")"
initial_size=$(du -hs | cut -f1)

# detecting quality
current_quality="$(${DETECTION_SCRIPT} -d "${PWD}" -s "${sample_size}")"
printf "\t%s%s\n" \
    "$(wrap_color 'green' "Quality Detected: ")" \
    "$(wrap_color 'aqua' "${current_quality}")"
if [[ "$current_quality" -gt "$quality" ]]; then
    printf "\tConverting files; this might take a while ...\n"
    # actual conversion
    converter_covert "${quality}"
else
    printf "\tThe files %s further at this quality\n" \
        "$(wrap_color 'bold' "$(wrap_color 'violet' "cannot be compressed")")"
fi

final_size=$(du -hs | cut -f1)
printf "\t%s%s\n" \
    "$(wrap_color 'bold' "$(wrap_color 'yellow' "Initial Size: ")")" \
    "$(wrap_color 'red' "${initial_size}")"
printf "\t%s%s\n" \
    "$(wrap_color 'bold' "$(wrap_color 'green' "Final Size: ")")" \
    "$(wrap_color 'aqua' "${final_size}")"

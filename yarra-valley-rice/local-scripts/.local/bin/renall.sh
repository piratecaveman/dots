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

BLKRENAME="/home/wraith/.local/bin/blkrename.sh"

while IFS= read -r -d '' folder; do
    printf "\t%s%s\n" \
        "$(wrap_color 'green' "Renaming files in ")" \
        "$(wrap_color 'bold' "$(wrap_color 'aqua' "${folder}")")"
    echo "$folder"
    cd "${folder}" || exit
    ${BLKRENAME}
    cd ..
done < <(fd --min-depth 1 --max-depth 1 --type d -0 --absolute-path)
echo

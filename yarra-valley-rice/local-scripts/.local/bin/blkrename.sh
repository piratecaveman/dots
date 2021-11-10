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

# define padding size
PADDING="${1}"
if [[ -z ${PADDING} ]]; then
    PADDING=4
fi

counter=1
current_time="$(date +%F)#$(date +%H-%m-%S)"
printf "\t%s%s\n" \
    "$(wrap_color 'green' "Renaming files in: ")" \
    "$(wrap_color 'bold' "$(wrap_color 'aqua' "${PWD}")")"
while IFS= read -r -d '' item; do
    printf -v current_pos "%0${PADDING}d" "${counter}"
    current_name=${item##*/}
    extension=${item##*.}
    extension=${extension,,}
    new_name="${PWD}/${current_time}#${current_pos}.${extension}"

    printf "\t%s%s%s%s\n" \
        "Renamed " \
        "$(wrap_color 'yellow' "${current_name}")" \
        " to " \
        "$(wrap_color 'aqua' "${current_pos}.${extension}")"

    mv "${item}" "${new_name}"
    counter=$((counter + 1))
done < <(fd --type f --max-depth 1 --min-depth 1 -e jpg -e jpeg -e webp -e png -e gif -0 --absolute-path)
echo

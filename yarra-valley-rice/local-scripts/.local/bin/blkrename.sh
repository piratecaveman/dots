#!/usr/bin/env bash

# colors
# UNDERLINE="$(tput sgr 0 1)"
BOLD="$(tput bold)"
# RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
# BLUE="$(tput setaf 4)"
# VIOLET="$(tput setaf 5)"
AQUA="$(tput setaf 6)"
# WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

# define padding size
PADDING="${1}"
if [[ -z ${PADDING} ]]; then
    PADDING=4
fi

counter=1
current_time="$(date +%F)#$(date +%H-%m-%S)"
printf "\t${GREEN}Renaming files in: ${BOLD}${AQUA}%s${RESET}\n" "${PWD}"
while IFS= read -r -d '' item; do
    printf -v current_pos "%0${PADDING}d" "${counter}"
    current_name=${item##*/}
    extension=${item##*.}
    extension=${extension,,}
    new_name="${PWD}/${current_time}#${current_pos}.${extension}"
    printf "\tRenamed ${YELLOW}%s${RESET} to ${AQUA}%s${RESET}\n" "${current_name}" "${current_pos}.${extension}"
    mv "${item}" "${new_name}"
    counter=$((counter + 1))
done < <(fd --type f --max-depth 1 --min-depth 1 -e jpg -e jpeg -e webp -e png -e gif -0 --absolute-path)
echo

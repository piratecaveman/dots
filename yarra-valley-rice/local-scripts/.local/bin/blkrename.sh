#!/usr/bin/env bash

# colors
UNDERLINE="$(tput sgr 0 1)"
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
VIOLET="$(tput setaf 5)"
AQUA="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

# define padding size
PADDING="${1}"
if [[ -z ${PADDING} ]]; then
  PADDING=4
fi

# renames all jpg jpeg webp and png files in the folder sequentially
counter=1
echo
printf "\t${RED}Making preparations for rename in: ${AQUA}%s${RESET}\n" "${PWD}"
while IFS= read -r -d '' item; do
  printf -v current_pos "%08d" "${counter}"
  extension=${item##*.}
  extension=${extension,,}
  new_name="${PWD}/${current_pos}-blkren.${extension}"
  mv "${item}" "${new_name}"
  counter=$((counter + 1))
done < <(find "${PWD}" -maxdepth 1 -mindepth 1 \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.png" -or -iname "*.webp" \) -print0)

counter=1
printf "\t${GREEN}Renaming files in: ${AQUA}%s${RESET}\n" "${PWD}"
while IFS= read -r -d '' item; do
  printf -v current_pos "%0${PADDING}d" "${counter}"
  current_name=${item##*/}
  extension=${item##*.}
  extension=${extension,,}
  new_name="${PWD}/${current_pos}.${extension}"
  printf "\tRenamed ${YELLOW}%s to ${AQUA}%s${RESET}\n" "${current_name}" "${current_pos}.${extension}"
  mv "${item}" "${new_name}"
  counter=$((counter + 1))
done < <(find "${PWD}" -maxdepth 1 -mindepth 1 \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.png" -or -iname "*.webp" \) -print0)
echo

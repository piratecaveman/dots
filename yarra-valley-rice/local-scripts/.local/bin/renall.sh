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


BLKRENAME="/home/wraith/.local/bin/blkrename.sh"

while IFS= read -r -d '' folder; do
  printf "\t${GREEN}Renaming files in ${BOLD}${AQUA}%s${RESET}\n" "${folder}"
  cd "${folder}" || exit
  ${BLKRENAME}
  cd ..
done <  <(find "${PWD}" -mindepth 1 -maxdepth 1 -type d -print0)
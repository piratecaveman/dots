#!/usr/bin/env bash
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
VIOLET="\[$(tput setaf 5)\]"
AQUA="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"
RESET="\[$(tput sgr0)\]"

# export PS1="${RED}[${AQUA}\u${WHITE}@${VIOLET}\h ${GREEN}\W${RED}]${WHITE}\$${RESET} "
export PS1="${RED} ${RESET}${AQUA} ${RESET}${GREEN} ${RESET}${RED}${BOLD} ${RESET} ${GREEN}\W${RESET} \$ "

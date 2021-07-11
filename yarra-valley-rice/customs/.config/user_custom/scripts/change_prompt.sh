#!/usr/bin/env bash

SCRIPTS="${USER_CUSTOM}/scripts"
COLORS="${SCRIPTS}/colors.sh"

source_file() {
    if [[ -f "${1}" ]]; then
        # shellcheck disable=SC1090
        source "${1}"
    fi
}

source_file "${COLORS}"
if [[ "${TERM}" == "linux" ]]; then
    export PS1="${COLOR_RED}[${COLOR_AQUA}\u${COLOR_WHITE}@${COLOR_VIOLET}\h ${COLOR_GREEN}\W${COLOR_RED}]${COLOR_WHITE}\$${COLOR_RESET} "
elif [[ "${TERM}" == "xterm-256color" ]]; then
    export PS1="${COLOR_RED}[${COLOR_AQUA}\u${COLOR_WHITE}@${COLOR_VIOLET}\h ${COLOR_GREEN}\W${COLOR_RED}]${COLOR_WHITE}\$${COLOR_RESET} "
else
    export PS1="${COLOR_RED} ${COLOR_RESET}${COLOR_AQUA} ${COLOR_RESET}${COLOR_GREEN} ${COLOR_RESET}${COLOR_RED}${COLOR_BOLD} ${COLOR_RESET} ${COLOR_GREEN}\W${COLOR_RESET} \$ "
fi

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

case "${TERM}" in
'linux' | 'xterm-256color')
    PS1=$(
        printf "%s%s%s%s%s%s%s" \
            "$(wrap_color 'red' '[')" \
            "$(wrap_color 'aqua' '\u')" \
            "$(wrap_color 'white' '@')" \
            "$(wrap_color 'violet' '\h')" \
            "$(wrap_color 'green' ' \W')" \
            "$(wrap_color 'red' ']')" \
            "$(wrap_color 'white' '\$ ')"
    )
    ;;
'alacritty')
    PS1=$(
        printf "%s%s%s%s%s%s" \
            "$(wrap_color 'red' ' ')" \
            "$(wrap_color 'aqua' ' ')" \
            "$(wrap_color 'green' ' ')" \
            "$(wrap_color 'bold' "$(wrap_color 'red' ' ')") " \
            "$(wrap_color 'green' '\W ')" \
            "$(wrap_color 'reset' '\$ ')"
    )
    ;;
*)
    PS1='[\u@\h \W]\$ '
    ;;
esac

export PS1

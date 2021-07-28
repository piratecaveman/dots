#!/usr/bin/env bash

# COLOR_UNDERLINE="$(tput sgr 0 1)"
# COLOR_BOLD="$(tput bold)"
# COLOR_RED="$(tput setaf 1)"
# COLOR_GREEN="$(tput setaf 2)"
# COLOR_YELLOW="$(tput setaf 3)"
# COLOR_BLUE="$(tput setaf 4)"
# COLOR_VIOLET="$(tput setaf 5)"
# COLOR_AQUA="$(tput setaf 6)"
# COLOR_WHITE="$(tput setaf 7)"
# COLOR_RESET="$(tput sgr0)"

COLOR_UNDERLINE="\[$(tput sgr 0 1)\]"
COLOR_BOLD="\[$(tput bold)\]"
COLOR_RED="\[$(tput setaf 1)\]"
COLOR_GREEN="\[$(tput setaf 2)\]"
COLOR_YELLOW="\[$(tput setaf 3)\]"
COLOR_BLUE="\[$(tput setaf 4)\]"
COLOR_VIOLET="\[$(tput setaf 5)\]"
COLOR_AQUA="\[$(tput setaf 6)\]"
COLOR_WHITE="\[$(tput setaf 7)\]"
COLOR_RESET="\[$(tput sgr0)\]"

unset_colors() {
    unset COLOR_UNDERLINE
    unset COLOR_BOLD
    unset COLOR_RED
    unset COLOR_GREEN
    unset COLOR_YELLOW
    unset COLOR_BLUE
    unset COLOR_VIOLET
    unset COLOR_AQUA
    unset COLOR_WHITE
    unset COLOR_RESET
}

set_colors() {
    export COLOR_UNDERLINE
    export COLOR_BOLD
    export COLOR_RED
    export COLOR_GREEN
    export COLOR_YELLOW
    export COLOR_BLUE
    export COLOR_VIOLET
    export COLOR_AQUA
    export COLOR_WHITE
    export COLOR_RESET
}

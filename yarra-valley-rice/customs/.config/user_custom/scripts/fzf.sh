#!/usr/bin/env bash

export FZF_COMPLETION_OPTS='--border --info=inline --cycle --layout=reverse-list'

__fzf_compgen_path() {
    fd --hidden --follow --exclude . "$1"
}

__fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude . "$1"
}

__fzf_comprun() {
    local command="$1"
    shift

    echo "$@"
    case "$command" in
    'cd') fzf "$@" --preview 'tree -C {} | head -200' ;;
    'export' | 'unset') fzf "$@" --preview "eval 'echo \$'{}" ;;
    *) fzf "$@" ;;
    esac
}

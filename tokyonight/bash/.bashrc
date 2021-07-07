#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [ "$(umask)" != "0022" ]; then
	umask 0022
fi

bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'
# bind '"\e[Z":menu-complete-backward'

source_file() {
	if [[ -f "${1}" ]]; then
		# shellcheck disable=1090
		source "${1}"
	fi
}

CUSTOM="${HOME}/.config/customization/environ"
ALIAS="${CUSTOM}/alias.d"
EXPORTS="${CUSTOM}/export.d"
SOURCES_LIST=(
	"${ALIAS}/alias.sh"
	"${EXPORTS}/exports.sh"
	"${EXPORTS}/change_prompt_colors.sh"
	"${EXPORTS}/fzf.sh"
	"${EXPORTS}/proxy.sh"
	"${EXPORTS}/onions.sh"
	"/usr/share/fzf/key-bindings.bash"
	"/usr/share/fzf/completion.bash"
	"/usr/share/fzf-tab-completion/bash/fzf-bash-completion.sh"
)

for i in "${SOURCES_LIST[@]}"; do
	source_file "${i}"
done

bind -x '"\C-\t": fzf_bash_completion'

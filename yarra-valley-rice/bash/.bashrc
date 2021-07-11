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

SCRIPTS="${USER_CUSTOM}/scripts"
SOURCES_LIST=(
	"${SCRIPTS}/exports.sh"
	"/usr/share/fzf/key-bindings.bash"
	"/usr/share/fzf/completion.bash"
	"/usr/share/fzf-tab-completion/bash/fzf-bash-completion.sh"
)

for item in "${SOURCES_LIST[@]}"; do
	source_file "${item}"
done

bind -x '"\C-\t": fzf_bash_completion'

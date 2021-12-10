#!/usr/bin/env bash

alias ls="ls -A --color=auto"
alias grep="grep --color=auto"
alias less="less -r"
alias ip="ip -c=always"
alias userctl="systemctl --user"
alias startvm="sudo systemctl start libvirtd.service"
alias cpas="cat .secrets/pass.txt | xclip -sel c"
alias clpas="head -n 10 /dev/null | xclip -sel c"
alias myip="curl https://checkip.amazonaws.com"
alias cman='PAGER=most man'
alias lsd="lsd -A"
alias exa="exa --icons"
alias fd="fd -H"

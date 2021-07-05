#!/usr/bin/env bash
alias ls="ls -A --color=always"
alias grep="grep --color=always"
alias less="less -r"
alias ip="ip -c=always"
alias userctl="systemctl --user"
alias startvm="sudo systemctl start libvirtd.service"
alias cpas="cat .secrets/pass.txt | xclip -sel c"
alias clpas="head -n 10 /dev/null | xclip -sel c"
alias myip="curl https://checkip.amazonaws.com"
alias reloadx='xrdb -load ${HOME}/.Xresources'
alias gotoonion="cd /media/ntfs/home/leshen/dens/onion-den/"
alias cman='PAGER=most man'

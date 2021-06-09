#!/usr/bin/env bash
read -r -p "Name: " NAME
read -r -p "Email: " EMAIL
read -r -p "ssh-key: " KEY

if [[ -z "${NAME}" ]]; then
    NAME="Pirate Caveman"
fi

if [[ -z "${EMAIL}" ]]; then
    EMAIL="piratecaveman@protonmail.com"
fi

if [[ -z "${KEY}" ]]; then
    KEY="/home/wraith/.ssh/id-rsa-octopus"
fi

git config --local user.name "${NAME}"
git config --local user.email "${EMAIL}"
git config --local color.ui true
git config --local color.status auto
git config --local color.branch auto
git config --local core.editor nvim
git config --local core.sshCommand "/usr/bin/ssh -i ${KEY}"

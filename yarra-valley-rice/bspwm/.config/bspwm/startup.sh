#!/usr/bin/env bash

pgrep -x picom >/dev/null || picom --experimental-backends -bc & disown -h
pgrep -x polkit-kde-auth >/dev/null || /usr/lib/polkit-kde-authentication-agent-1 & disown -h
pgrep -x dunst >/dev/null || dunst & disown -h
pgrep -f "${HOME}"/.node_modules/bin/gt >/dev/null || "${HOME}"/.node_modules/bin/gt --dns-type "tls" --dns-server "45.90.28.0#8622a7.dns1.nextdns.io" & disown -h
pgrep -x flameshot >/dev/null || flameshot gui
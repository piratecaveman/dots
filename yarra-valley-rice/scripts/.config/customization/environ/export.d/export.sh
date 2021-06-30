#!/usr/bin/env bash

export TERMINAL="/usr/bin/urxvt"
export TDESKTOP_DISABLE_TRAY_COUNTER=1

join_path() {
	path="${1}"
	if [[ ":${PATH}:" != *":${path}:"* ]]; then
		export PATH="${PATH}:${path}"
	fi
}

PATH_LIST=(
	"${HOME}/.local/bin"
	"${HOME}/storage/development/flutter/bin"
	"${HOME}/.node_modules/bin"
)
for i in "${PATH_LIST[@]}"; do
	join_path "${i}"
done

export VISUAL="/usr/bin/nvim"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3'
export QT_QPA_PLATFORMTHEME="qt5ct"
export ANDROID_SDK_ROOT="${HOME}/storage/development/android-sdk"
export PAGER="most"

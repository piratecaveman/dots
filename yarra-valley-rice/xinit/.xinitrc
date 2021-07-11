#!/usr/bin/sh

eval "$(ssh-agent)"
export AWT_TOOLKIT=MToolkit
export GTK_IM_MODULE=ibus
export XMODIFIER=@im=ibus
export QT_IM_MODULE=ibus
export USER_CUSTOM="/home/wraith/.config/user_custom"
exec bspwm

#!/usr/bin/env bash

CONFIG="${USER_CUSTOM}/configs"
COLORSCHEMES="${USER_CUSTOM}/colorschemes"

echo "#include \"${CONFIG}/urxvt.conf\""
echo "#include \"${CONFIG}/xft.conf\""
echo "#include \"${CONFIG}/xterm.conf\""
echo "#include \"${CONFIG}/xft.conf\""
echo "#include \"${COLORSCHEMES}/yarra-valley.conf\""

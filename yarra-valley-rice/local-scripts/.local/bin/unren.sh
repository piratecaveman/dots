#! /bin/bash

# UnRen for Mac v 0.8.2 by goobdoob - https://f95zone.to/members/goobdoob.334840/
# Original version by jimmy5 - https://f95zone.to/members/jimmy5.179689/
# https://f95zone.com/threads/unren-for-macos.16887/

# Based on UnRen.bat v0.8 by Sam - https://f95zone.to/members/sam.7899/
# https://f95zone.to/threads/unren-bat-v0-8-rpa-extractor-rpyc-decompiler-console-developer-menu-enabler.3083/

# Using:
# rpatool - https://github.com/Shizmob/rpatool
# unrpyc - https://github.com/CensoredUsername/unrpyc

# Change Log:
#
# v0.8.2:
# Switch shell used back to bash (it was changed to zsh to test something)
#
# v0.8.1:
# Handle a relative path used to invoke the script. Thanks to enigma9999 @ www.f95zone.to for the bug report. 
#   Why not use realpath? It doesn't exist by default on OSX.
# Fixed the quickSave and quickLoad keys. They were inadvertently commented out earlier. Thanks to Joel69 @ www.f95zone.to for the bug report.
# Remove leading and trailing single quotes from the game directory.
#   Drag-and-drop on Linux puts single quotes around the path. This enables drag-and-drop on Linux.
#   Thanks to swp and cold_arctus on www.f95zone.to for the bug report.
# Updated to unrpyc v1.1.3, which should fix some of the decompiling issues with newer versions of Ren'Py.
#
# v0.8:
# Changed version number to sync with UnRen.bat.
# Updated to the latest (as of September 3, 2019) rpatool (v0.8) and unrpyc
# Changed rpatool and unrpyc encoding. They are now simple files in the zip archive.
#
# v0.4:
# Fixed a bug when working with more than 1 .rpa file
#
# v0.3:
# Changed rpyc decompile to decompile rpyc files in all game directories recursively.
# Added option to overwrite existing rpy files. Thanks to randomname42 @ www.f95zone.com for the suggestion.
# Changed base64 option -D to --decode because -D doesn't work on GNU base64.
# Changed base64 option -o to > because -o doesn't work on GNU base64. Thanks to cold_arctus @ www.f95zone.com for the base64 bug reports.
# Fixed a bug having to do with spaces in the path to the game. Thanks to waveofpig @ www.f95zone.com for the bug report.
# Changed to splash screen to say "@ www.f95zone.com" instead of "@f95zone".
# Detect if there are no .rpa files to extract and report that, instead of getting an error from the shell.
#
# v0.2:
# Added line to force script to run in bash.
# Allow user to specify game directory on the command line.
# Extract packages in place instead of in a subfolder, which caused games to crash with
#   double definitions.
# Print names of rpa packages being extracted.
# Changed script decompile to use unrpyc under python instead of un.rpyc inside the game.
# Removed options to uninstall un.rpyc and remove extracted packages.
# Added option to quit from main menu.
# Fixed handling of games with spaces in their names.
# Simplified code by removing some recursion and putting main menu in a loop.
# Check for pc game folder if the script can't find it in the Mac location.
#

# ------------------------------------------------------------------------------------------
# Configuration
    quicksavekey="K_F5"
    quickloadkey="K_F9"
# End of Configuration

# ------------------------------------------------------------------------------------------
# If you touch anything other than the configuration, and this stops working don't complain.
# ------------------------------------------------------------------------------------------

ARG1=$1
num_args=$#
version="0.8.2"
rpatool_raw=`dirname "$0"`"/UnRen Tools/rpatool"
rpatool=`python -c "import os; print(os.path.realpath('$rpatool_raw'))"`
unrpyc_raw=`dirname "$0"`"/UnRen Tools/unrpyc.py"
unrpyc=`python -c "import os; print(os.path.realpath('$unrpyc_raw'))"`
pyver=`python -c 'import sys; print(sys.version_info[0])'`
# Python 3 is not currently supported by unrpyc.
if [ $pyver -eq 2 ]; then
    python='python'
else
    python='python2'
fi

clear

#Splash Screen
function init
{
    echo "UnRen for Mac and Linux v$version"
    echo "by goobdoob @ www.f95zone.to"
    echo "based on the original version by jimmy5 @ www.f95zone.to"
    echo "and UnRen.bat by sam @ www.f95zone.to"
    if command -v $python &>/dev/null; then
        echo "Python is installed, detected"
    else
        echo "$python is not installed, or not added to your PATH. Please install/reinstall it from python.org"
        echo "Python 3 is not supported by unrpyc; you need a Python 2 installation"
        exit
    fi
    if ! [ -e "$rpatool" ] || ! [ -e "$unrpyc" ]; then
        echo "Error - cannot find rpatool or unrpyc in UnRen v$version Tools. Exiting"
        exit
    fi
    if [ $num_args -ne 1 ]; then
        echo "Please drag + drop the game you are wanting to modify into the terminal."
        read appdir
    else
        echo "Working with directory $ARG1"
        appdir=$ARG1
    fi
    temp="${appdir%\'}"
    appdir="${temp#\'}"
    game=$appdir/Contents/Resources/autorun/game
    if [ ! -d "$game" ]; then
        # Can't find the game directory in the Mac spot; see if it's in the PC spot
        game=$appdir/game
        if [ ! -d "$game" ]; then
            echo "Can't find the game directory in $appdir! Exiting now"
            exit
        fi
    fi
    menu
}

function menu
{
    while :
    do
        echo
        echo "What would you like to do?"
        echo "  1) Extract RPA packages"
        echo "  2) Decompile rpyc files"
        echo "  3) Decompile rpyc files, overwriting existing rpy files"
        echo "  4) Enable Console and Developer Menu"
        echo "  5) Enable Quick Save and Quick Load"
        echo "  6) Force enable skipping of unseen content"
        echo "  7) Force enable rollback (scroll wheel)"
        echo "  8) Open game directory"
        echo
        echo "  99) Options 1-7 (no overwrite)"
        echo
        echo "  q) quit UnRen"
        echo
        choice
    done
}

function choice
{
    read choicev
    case "$choicev" in
    "1")
        extract
        ;;
    "2")
        decompile
        ;;
    "3")
        decompileoverwrite
        ;;
    "4")
        console
        ;;
    "5")
        quick
        ;;
    "6")
        skip
        ;;
    "7")
        rollback
        ;;
    "8")
        opengame
        ;;
    "99")
        extract
        decompile
        console
        quick
        skip
        rollback
        ;;
    "q")
        exit
        ;;
    *)
        echo "Please make a valid selection"
        choice
        ;;
    esac
}

function opengame
{
    open "$game"
}

function extract
{
    pushd "$game" > /dev/null
    files=(*.rpa)
    if [ -e ${files[0]} ]; then
        echo "Extracting RPA packages"
        for f in *.rpa; do
            echo "extracting $f"
            $python "$rpatool" -x "$f"
        done
    else
        echo "No RPA packages found"
    fi
    popd > /dev/null
}

function decompile
{
    echo "Decompiling rpyc files"
    pushd "$game" > /dev/null
    $python "$unrpyc" "."
    popd > /dev/null
}

function decompileoverwrite
{
    echo "Decompiling rpyc files, overwriting existing rpy files"
    pushd "$game" > /dev/null
    $python "$unrpyc" "." "-c"
    popd > /dev/null
}

function console
{
    if [  -f "$game/unren-dev.rpy" ]; then
        rm "$game/unren-dev.rpy"
    fi

    touch "$game/unren-dev.rpy"
    echo "init 999 python:" > "$game/unren-dev.rpy"
    echo "  config.developer = True" >> "$game/unren-dev.rpy"
    echo "  config.console = True" >> "$game/unren-dev.rpy"
    echo "Added - Console: Shift + O"
    echo "Added - Dev Menu: Shift + D"
}

function quick
{
    if [  -f "$game/unren-quick.rpy" ]; then
        rm "$game/unren-quick.rpy"
    fi

    touch "$game/unren-quick.rpy"
    echo "init 999 python:" > "$game/unren-quick.rpy"
    echo "  try:" >> "$game/unren-quick.rpy"
    echo "    config.underlay[0].keymap['quickSave'] = QuickSave()" >> "$game/unren-quick.rpy"
    echo "    config.keymap['quickSave'] = '$quicksavekey'" >> "$game/unren-quick.rpy"
    echo "    config.underlay[0].keymap['quickLoad'] = QuickLoad()" >> "$game/unren-quick.rpy"
    echo "    config.keymap['quickLoad'] = '$quickloadkey'" >> "$game/unren-quick.rpy"
    echo "  except:" >> "$game/unren-quick.rpy"
    echo "    pass" >> "$game/unren-quick.rpy"
    echo "Added - Quick Save: $quicksavekey"
    echo "Added - Quick Load: $quickloadkey"
}

function skip
{
    if [  -f "$game/unren-skip.rpy" ]; then
        rm "$game/unren-skip.rpy"
    fi

    touch "$game/unren-skip.rpy"
    echo "init 999 python:" > "$game/unren-skip.rpy"
    echo "  _preferences.skip_unseen = True" >> "$game/unren-skip.rpy"
    echo "  renpy.game.preferences.skip_unseen = True" >> "$game/unren-skip.rpy"
    echo "  renpy.config.allow_skipping = True" >> "$game/unren-skip.rpy"
    echo "  renpy.config.fast_skipping = True" >> "$game/unren-skip.rpy"
    echo "Added - You can now skip text with Tab & Command keys."
}

function rollback
{
    if [  -f "$game/unren-rollback.rpy" ]; then
        rm "$game/unren-rollback.rpy"
    fi

    touch "$game/unren-rollback.rpy"
    echo "init 999 python:" > "$game/unren-rollback.rpy"
    echo "  renpy.config.rollback_enabled = True" >> "$game/unren-rollback.rpy"
    echo "  renpy.config.hard_rollback_limit = 256" >> "$game/unren-rollback.rpy"
    echo "  renpy.config.rollback_length = 256" >> "$game/unren-rollback.rpy"
    echo "  def unren_noblock( *args, **kwargs ):" >> "$game/unren-rollback.rpy"
    echo "    return" >> "$game/unren-rollback.rpy"
    echo "  renpy.block_rollback = unren_noblock" >> "$game/unren-rollback.rpy"
    echo "You can now rollback using the scroll wheel"
}

init
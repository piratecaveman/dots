#!/usr/bin/env bash

setproxy() {
    OPTIONS="-Djava.net.useSystemProxies=true"
    export _JAVA_OPTIONS="${_JAVA_OPTIONS} ${OPTIONS}"
    export http_proxy="http://127.0.0.1:8000/"
    export ftp_proxy="ftp://127.0.0.1:8000/"
    export rsync_proxy="rsync://127.0.0.1:8000/"
    export no_proxy="localhost,127.0.0.1,192.168.1.1,192.168.0.1,::1,*.local"
    export HTTP_PROXY="http://127.0.0.1:8000/"
    export FTP_PROXY="ftp://127.0.0.1:8000/"
    export RSYNC_PROXY="rsync://127.0.0.1:8000/"
    export NO_PROXY="localhost,127.0.0.1,192.168.1.1,192.168.0.1,::1,*.local"
    export https_proxy="http://127.0.0.1:8000/"
    export HTTPS_PROXY="http://127.0.0.1:8000/"
}
remproxy() {
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3'
    unset http_proxy="http://127.0.0.1:8000/"
    unset ftp_proxy="ftp://127.0.0.1:8000/"
    unset rsync_proxy="rsync://127.0.0.1:8000/"
    unset no_proxy="localhost,127.0.0.1,192.168.1.1,192.168.0.1,::1,*.local"
    unset HTTP_PROXY="http://127.0.0.1:8000/"
    unset FTP_PROXY="ftp://127.0.0.1:8000/"
    unset RSYNC_PROXY="rsync://127.0.0.1:8000/"
    unset NO_PROXY="localhost,127.0.0.1,192.168.1.1,192.168.0.1,::1,*.local"
    unset https_proxy="http://127.0.0.1:8000/"
    unset HTTPS_PROXY="http://127.0.0.1:8000/"
}

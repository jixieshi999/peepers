#!/usr/bin/bashir

set -o errexit
set -o nounset

usage='
    Build, install and/or run Peepers

    Usage:

        # build.sh [-bcilouv]

    -b  build
    -c  clean
    -i  install
    -l  launch
    -o  log
    -u  uninstall
    -v  video
'

build=false
clean=false
install=false
launch=false
log=false
uninstall=false
video=false

if [[ $# -eq 0 ]]; then
    echo "${usage}";
    exit 1
fi

while getopts :bcilouv opt; do
    case "${opt}" in
        b) build=true ;;
        c) clean=true ;;
        i) install=true ;;
        l) launch=true ;;
        o) log=true ;;
        u) uninstall=true ;;
        v) video=true ;;
        \?|*)
            echo "${usage}"
            exit 1
            ;;
    esac
done
unset opt usage

cd ..

if $uninstall; then
    adb uninstall com.foxdogstudios.peepers
fi
unset uninstall

if $clean; then
    ant clean
fi
unset clean

if $build; then
    ant debug
fi
unset build

if $install; then
    ant installd
fi
unset install

if $launch; then
    al.py
fi
unset launch

if $video; then
    scripts/video.sh
fi

if $log; then
    logdog.py
fi
unset log

wait

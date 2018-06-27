#!/bin/bash

set -x

PKG=$(echo $1|awk -F":" '{print $1}')
INSTALL=$(echo $1|awk -F":" '{print $2}')

echo ====================================
echo "Building: $PKG"
echo ====================================

if test -v $PKG; then
    echo "No target aur package provided"
else
    cd workshop
    if ! test -d $PKG; then
        git clone https://aur.archlinux.org/$PKG.git $PKG
    fi
    cd $PKG
fi

function install_wrapper {
    err="/tmp/makepkg-$RANDOM"
    makepkg -s --noconfirm 2>&1| tee -a $err
    failed_pkgs=$(cat $err|grep "error: failed"|awk -F\' '{print $2}')
    if [[ $failed_pkgs != "" ]]; then
        for pkg in $failed_pkgs; do
            pkg_name=$(echo $pkg|awk 'match($0, /[a-zA-Z0-9-]+/) {print substr($0, RSTART, RLENGTH-2)}'|sed -e 's/^\([a-zA-Z0-9]\+\)-\?$/\1/')
            pkg_url="https://archive.archlinux.org/packages/$(echo $pkg_name|cut -c 1)/$pkg_name/$pkg"
            sudo pacman -U $pkg_url --noconfirm
        done
        install_wrapper
    fi
}

install_wrapper

if test $INSTALL; then
    sudo pacman -U *.pkg.tar.xz
fi

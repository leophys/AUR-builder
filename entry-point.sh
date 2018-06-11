#!/bin/bash

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

makepkg -s

if test $INSTALL; then
    sudo pacman -U *.pkg.tar.xz
fi

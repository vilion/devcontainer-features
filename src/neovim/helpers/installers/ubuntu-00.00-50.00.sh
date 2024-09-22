#!/bin/bash

set -eux

TEMP_DIR="$(mktemp -d)"
cd "$TEMP_DIR"

apt update
apt install -y wget

ARCH="$(uname -m)"
if [ "$ARCH" = "aarch64" ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    mv --force nvim.appimage /usr/local/bin/nvim
else
    wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz"
    tar xf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz

    # move the executable
    mv --force nvim-linux64/bin/nvim /usr/local/bin

    # --symbolic & --force flags does not exist in alpine & busybox
    ln -s -f /usr/local/bin/nvim /usr/bin

    # copy share files
    cp --recursive --update --verbose nvim-linux64/share/* /usr/local/share
    rm -rf nvim-linux64/share

    # copy libs
    cp --recursive --update --verbose nvim-linux64/lib/* /usr/local/lib
    rm -rf nvim-linux64/lib
fi

# copy man pages
# cp --recursive --update --verbose nvim-linux64/man/* /usr/local/man
# rm -rf nvim-linux64/man

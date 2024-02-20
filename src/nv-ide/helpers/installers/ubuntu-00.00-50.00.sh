#!/bin/bash

set -eux

mkdir /root/.config
cp -R helpers/installers/neovim /root/.config/nvim

if command -v nvim &>/dev/null; then
	nvim --headless "+Lazy! sync" +qa
fi

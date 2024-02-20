#!/bin/bash

set -eux

apt update

cp -R ./neovim /root/.config/nvim

if command -v nvim &>/dev/null; then
	nvim --headless "+Lazy! sync" +qa
fi

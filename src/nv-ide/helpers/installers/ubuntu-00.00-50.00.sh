#!/bin/bash

set -eux

mkdir /home/neovimuser/.config
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
su - neovimuser -c 'nvim --headless "+TSInstallSync! all" +qa'
su - neovimuser -c 'updatedb'

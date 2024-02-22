#!/bin/bash

set -eux

su - neovimuser -c 'mkdir /home/neovimuser/.config'
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim
chown neovimuser -R /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
updatedb

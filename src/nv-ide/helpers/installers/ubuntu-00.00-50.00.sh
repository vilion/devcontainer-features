#!/bin/bash

set -eux

su - neovimuser -c 'mkdir /home/neovimuser/.config'
su - neovimuser -c 'cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim'

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
su - neovimuser -c 'nvim --headless "+TSInstallSync! all" +qa'
updatedb

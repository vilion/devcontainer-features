#!/bin/bash

set -eux

mkdir /home/rails/.config
cp -R helpers/installers/config-nvim /home/rails/.config/nvim

su - rails -c 'nvim --headless "+Lazy! sync" +qa'
su - rails -c 'nvim --headless "+TSInstall! all" +qa'

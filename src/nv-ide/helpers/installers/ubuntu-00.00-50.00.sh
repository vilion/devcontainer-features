#!/bin/bash

set -eux

su - rails
mkdir /home/rails/.config
cp -R helpers/installers/config-nvim /home/rails/.config/nvim

mkdir /root/.config
cp -R helpers/installers/config-nvim /root/.config/nvim

nvim --headless "+Lazy! sync" +qa

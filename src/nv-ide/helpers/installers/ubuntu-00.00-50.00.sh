#!/bin/bash

set -eux

su rails
mkdir /home/rails/.config
cp -R helpers/installers/config-nvim /home/rails/.config/nvim

nvim --headless "+Lazy! sync" +qa

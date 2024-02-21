#!/bin/bash

set -eux

mkdir /home/rails/.config
cp -R helpers/installers/config-nvim /home/rails/.config/nvim

nvim --headless "+Lazy! sync" +qa

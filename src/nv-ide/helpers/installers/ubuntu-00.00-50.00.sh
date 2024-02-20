#!/bin/bash

set -eux

mkdir /root/.config
cp -R helpers/installers/neovim /root/.nv-ide

nvim --headless "+Lazy! sync" +qa

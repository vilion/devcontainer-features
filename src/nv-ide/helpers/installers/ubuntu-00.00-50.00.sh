#!/bin/bash

set -eux

mkdir /root/.config
cp -R helpers/installers/config-nvim /root/.config/nvim

nvim --headless "+Lazy! sync" +qa

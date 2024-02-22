#!/bin/bash

set -eux

su - neovimuser -c 'mkdir /home/neovimuser/.config'
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim
chown neovimuser:neovimuser -R /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
rm -rf /usr/local/bundle
mkdir /usr/local/bundle
chown neovimuser:neovimuser -R /usr/local/bundle
rm -rf /usr/local/lib/ruby
mkdir /usr/local/lib/ruby
chown neovimuser:neovimuser -R /usr/local/lib/ruby
su - neovimuser -c 'cd /app && bundle install --clean'
updatedb

#!/bin/bash

set -eux

su - neovimuser -c 'mkdir /home/neovimuser/.config'
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim
chown neovimuser:neovimuser -R /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
rm -rf /usr/local/bundle
mkdir /usr/local/bundle
chown neovimuser:neovimuser -R /usr/local/bundle
chown neovimuser:neovimuser -R /usr/local/lib/ruby
mkdir /app/.bundle
touch /app/.bundle/config
chown neovimuser:neovimuser -R /app/.bundle
cp /root/.git-credentials /home/neovimuser/
cp /root/.gitconfig /home/neovimuser/
chown neovimuser:neovimuser -R /home/neovimuser/.gitconfig
chown neovimuser:neovimuser -R /home/neovimuser/.git-credentials
chmod 777 -R /usr/local/bin
su - neovimuser -c 'cd /app && bundle install --clean'
updatedb

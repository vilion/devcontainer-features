#!/bin/bash

set -eux

su - neovimuser -c 'mkdir /home/neovimuser/.config'
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim
chown neovimuser:neovimuser -R /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa'
if [ -d "/usr/local/bundle" ]
then
	rm -rf /usr/local/bundle
	mkdir /usr/local/bundle
	chmod 777 -R /usr/local/bundle
	chmod 777 -R /usr/local/lib/ruby
	chown neovimuser:neovimuser -R /usr/local/bundle
fi

if [ -d "/app" ]
then
	mkdir /app/.bundle
	touch /app/.bundle/config
	chown neovimuser:neovimuser -R /app
fi

if [ -e "/root/.git-credentials" ]
then
	cp /root/.git-credentials /home/neovimuser/
	cp /root/.gitconfig /home/neovimuser/
	chown neovimuser:neovimuser -R /home/neovimuser/.gitconfig
	chown neovimuser:neovimuser -R /home/neovimuser/.git-credentials
fi

chmod 777 -R /usr/local/bin
if command -v bundle
then
	#su neovimuser -c 'cd /app && bundle install && bundle exec rbs collection init && bundle exec rbs collection install'
	su neovimuser -c 'cd /app && bundle install'
	chown neovimuser:neovimuser -R /usr/local/bundle/cache/bundler
	su neovimuser -c 'cd /app && git config --global --add safe.directory /app'
fi

if command -v updatedb
then
	updatedb
fi
apt-get install -y default-mysql-server

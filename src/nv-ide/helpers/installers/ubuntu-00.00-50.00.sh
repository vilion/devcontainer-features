#!/bin/bash

set -eux

if [ ! -d "/home/neovimuser/.config" ]; then
	su - neovimuser -c 'mkdir /home/neovimuser/.config'
fi
cp -R helpers/installers/config-nvim /home/neovimuser/.config/nvim
chown neovimuser:neovimuser -R /home/neovimuser/.config/nvim

su - neovimuser -c 'nvim --headless "+Lazy! sync" +qa & wait'

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
	su neovimuser -c 'cd /app && git config --global --add safe.directory /app'
	su neovimuser -c 'cd /app && git config --global user.email "takabatakekoichi@gmail.com"'
	su neovimuser -c 'cd /app && git config --global user.name "takabatake"'
	su neovimuser -c 'cd /app && bundle install & wait'
	su neovimuser -c 'cd /app && gem install ruby-lsp ruby-lsp-rails ruby-lsp-rspec neovim rbs & wait'
	su neovimuser -c 'cd /app && rbs collection install & wait'
	su neovimuser -c 'cd /app && yard gems & wait'
fi

if command -v updatedb
then
	updatedb
fi
apt-get install -y default-mysql-server
cd /tmp

su -l neovimuser << 'EOF'
	luarocks install --lua-version 5.1 tiktoken_core
EOF
# mkdir -p /etc/apt/keyrings
# curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --no-tty --dearmor -o /etc/apt/keyrings/charm.gpg
# echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
# apt update -y && apt install glow -y

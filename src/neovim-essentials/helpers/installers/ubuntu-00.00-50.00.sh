#!/bin/bash

set -euxo pipefail

apt update

env

pkgs=()

if [ $GIT = "true" ]; then
	pkgs+=("git")
fi

if [ $BUILD_ESSENTIAL = "true" ]; then
	pkgs+=("build-essential")
fi

if [ $WGET = "true" ]; then
	pkgs+=("wget")
fi

if [ $CURL = "true" ]; then
	pkgs+=("curl")
fi

if [ $PYTHON3 = "true" ]; then
	pkgs+=("python3")
fi

if [ $PIP3 = "true" ]; then
	pkgs+=("python3-pip")
fi

if [ $PYTHON_IS_PYTHON3 = "true" ]; then
	pkgs+=("python-is-python3")
fi

if [ $RIPGREP = "true" ]; then
	pkgs+=("ripgrep")
fi

if [ $UNZIP = "true" ]; then
	pkgs+=("unzip")
fi

apt install -y "${pkgs[@]}"
curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
apt-get update
apt install nodejs -y
apt install xsel xclip wl-clipboard -y

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

adduser --uid 1000 neovimuser

pip3 install pynvim
if command -v gem
then
	gem install neovim
fi
npm install -g neovim
npm install -g @fivetrandevelopers/dbt-language-server
apt-get install fd-find
apt-get install mlocate

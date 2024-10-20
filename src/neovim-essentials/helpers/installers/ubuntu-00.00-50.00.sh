#!/bin/bash

set -euxo pipefail

apt update

env

pkgs=()

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

pkgs+=("unzip")
pkgs+=("libreadline-dev")
pkgs+=("lua5.4")
pkgs+=("fzf")
pkgs+=("luajit")
pkgs+=("autotools-dev")
pkgs+=("autoconf")
pkgs+=("pkg-config")
pkgs+=("fonts-liberation")
pkgs+=("dbus")
pkgs+=("fonts-dejavu-core")
pkgs+=("fonts-dejavu")
pkgs+=("fonts-freefont-ttf")
pkgs+=("upower")
pkgs+=("liblua5.4-dev")
pkgs+=("opam")
pkgs+=("bubblewrap")

cd /tmp
apt install -y "${pkgs[@]}"
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz \
	&& tar -xzpf luarocks-3.11.1.tar.gz \
	&& cd luarocks-3.11.1 \
	&& ./configure --with-lua-include=/usr/include/lua5.4 --with-lua-bin=/usr/bin \
        && make \
        && make install

luarocks config variables.LUA_INCDIR /usr/include/lua5.4
# luarocks install jsregexp

cd /tmp
rm -rf /tmp/ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
make install
ctags --version

cd /tmp
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if [ "$(uname -m)" = "aarch64" ]; then
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
else
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
fi
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

if [ ! -d "/home/neovimuser/.config/lazygit" ]; then
    mkdir -p /home/neovimuser/.config/lazygit
    touch /home/neovimuser/.config/lazygit/config.yml
fi

cat << 'EOFLAZY' > /home/neovimuser/.config/lazygit/config.yml
os:
  editPreset: "nvim-remote"
EOFLAZY

id -u neovimuser &>/dev/null && userdel -r neovimuser
adduser --uid 1000 neovimuser

pip3 install pynvim
pip3 install pre-commit
npm install -g neovim
npm install -g @fivetrandevelopers/dbt-language-server
npm install -g tree-sitter-cli
apt-get install fd-find less
apt-get install mlocate

apt-get install -y gettext \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    libghc-zlib-dev \
    libssl-dev \
    make \
    wget \
    libx11-dev \
    libxtst-dev \
    libxt-dev \
    libsm-dev \
    libxpm-dev \
    openssh-server

# cd /tmp
# wget https://storage.googleapis.com/chrome-for-testing-public/128.0.6613.119/linux64/chromedriver-linux64.zip
# unzip chromedriver-linux64.zip
# cp chromedriver-linux64/chromedriver /usr/bin/

wget https://github.com/git/git/archive/refs/tags/v2.59.0.tar.gz \
	&& tar -xzf v2.59.0.tar.gz \
	&& cd git-* \
	&& make prefix=/usr/local all \
	&& make prefix=/usr/local install

opam init --disable-sandboxing --yes
opam switch create 4.14.2 --yes
eval $(opam env --switch=4.14.2)

cd /tmp
wget https://github.com/bcpierce00/unison/archive/v2.53.5.tar.gz \
	&& tar -xzf v2.53.5.tar.gz \
	&& cd unison-2.53.5 \
        && make \
        && make install

cd /tmp

apt install xsel xclip wl-clipboard -y
apt-get install -y xsel xclip wl-clipboard

su -l neovimuser << 'EOF'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH=$PATH:$HOME/.cargo/bin
rustup update
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
if command -v gem
then
	gem install neovim
fi
cargo install lsp-ai
EOF

# Add SSH agent initialization to neovimuser's bashrc
cat << 'EOL' >> /home/neovimuser/.bashrc
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
EOL

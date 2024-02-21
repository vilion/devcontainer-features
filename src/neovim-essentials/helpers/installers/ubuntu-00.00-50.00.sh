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

wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb
apt-get install -y lsb-release
apt-get install -y mysql-apt-config
dpkg -i mysql-apt-config_0.8.29-1_all.deb
apt-get update -y
apt-get install -y mysql-client

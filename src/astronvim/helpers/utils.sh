#!/bin/bash

set -eux

get_os_info() {
	if [ -f /etc/os-release ]; then
		. /etc/os-release
		echo "$ID" "$VERSION_ID"
	else
		echo "/etc/os-release file was not found in the container" >&2
		echo "Unable to install neovim without knowing the OS" >&2
		exit 1
	fi
}

has_matching_version() {
	IFS="." read -r -a start <<<"$1"
	IFS="." read -r -a end <<<"$2"
	IFS="." read -r -a version <<<"$3"

	if [ ${version[0]} -gt ${start[0]} ] && [ ${version[0]} -lt ${end[0]} ]; then
		echo 1
		return
	fi

	if [ ${version[0]} = ${start[0]} ]; then
		for ((i = 0; i < ${#version[@]}; i++)); do
			if [ ${version[i]} -lt ${start[i]} ]; then
				echo 0
				return
			fi
		done

		echo 1
		return
	fi

	if [ ${version[0]} = ${end[0]} ]; then
		for ((i = 0; i < ${#version[@]}; i++)); do
			if [ ${version[i]} -gt ${end[i]} ]; then
				echo 0
				return
			fi
		done

		echo 1
		return
	fi
}

get_os_info_from_path() {
	# extract the file name
	local path="$(basename $1)"

	# remove the file extension
	local path="${path%.*}"

	IFS="-" read -a info <<<"$path"

	echo "${info[0]}" "${info[1]}" "${info[2]}"
}

source_matching_installer() {
	. helpers/installers/ubuntu-00.00-50.00.sh
}

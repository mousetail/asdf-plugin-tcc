#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for Tcc.
TOOL_NAME="TCC"
TOOL_TEST="tcc --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	curl -s https://mirror.accum.se/mirror/gnu.org/savannah/tinycc/ |
		grep -oE "\"tcc-([[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+)\.tar.bz2\"" |
		grep -oE "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+" |
		uniq
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# TODO: Adapt the release URL convention for plugin-tcc
	url="https://mirror.accum.se/mirror/gnu.org/savannah/tinycc/tcc-${version}.tar.bz2"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi
	(
		local work_dir
		work_dir="$(mktemp -d)"

		mkdir -p "$install_path"
		mkdir -p "$install_path/bin"
		mkdir -p "$install_path/lib"
		mkdir -p "$install_path/include"

		cp -r "$ASDF_DOWNLOAD_PATH"/* "$work_dir"

		cd "$work_dir"
		patch -p1 <"${plugin_dir}/lib/fixes.patch" &&
			bash ./configure --strip-binaries --bin="${install_path}/bin" --prefix="${install_path}" --exec-prefix="${install_path}" &&
			make &&
			make install

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

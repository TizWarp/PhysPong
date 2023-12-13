#!/bin/sh
echo -ne '\033c\033]0;Pongbutnot\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/PhysPong.x86_64" "$@"

#!/bin/sh
echo -ne '\033c\033]0;Pongbutnot\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/PhysPong-0.0.0.2.x86_64" "$@"

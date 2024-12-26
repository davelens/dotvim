#!/bin/sh

# Stops further execution after any error.
set -e

SCRIPT_DIR=$(dirname "$(realpath "$0")")

source ${SCRIPT_DIR}/helpers.sh

getnf -u DroidSansMono,Hack && echo "$(check) Nerd fonts uninstalled"

[ -f ~/.config/dvim ] && rm ~/.config/dvim && echo "$(check) Removed dvim config"
[ -f ~/.local/bin/dvim ] && rm ~/.local/bin/dvim && echo "$(check) Removed dvim executable"

echo "$(check) dvim successfully uninstalled"

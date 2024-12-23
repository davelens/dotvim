#!/bin/sh

# Stops further execution after any error.
set -e

source helpers.sh

[[ getnf -u DroidSansMono,Hack ]] && echo "$(check) Nerd fonts uninstalled"

[ -f ~/.local/bin/dvim ] && rm ~/.local/bin/dvim && echo "$(check) Removed dvim executable"

echo "$(check) dvim successfully uninstalled"

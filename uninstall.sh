#!/bin/sh

# Stops further execution after any error.
set -e

source helpers.sh

# nvim uninstall
[ -L ~/.config/nvim ] && rm ~/.config/nvim
[ -L ~/.vim ] && rm ~/.vim
[ -L ~/.vimrc ] && rm ~/.vimrc
[ -f ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf ] && rm ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf

# dvim uninstall
[[ getnf -u DroidSansMono,Hack ]] && echo "$(check) Nerd fonts uninstalled"
[ -f ~/.local/bin/dvim ] && rm ~/.local/bin/dvim && echo "$(check) Removed dvim executable"

echo "$(check) dvim successfully uninstalled"

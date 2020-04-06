#!/bin/sh

[ -L ~/.config/nvim ] && rm ~/.config/nvim
[ -L ~/.vim ] && rm ~/.vim
[ -L ~/.vimrc ] && rm ~/.vimrc
[ -f ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf ] && rm ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf

echo 'Done.';

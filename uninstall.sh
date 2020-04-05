#!/bin/sh

[ -f ~/.config/nvim ] && rm ~/.config/nvim
[ -f ~/.vim ] && rm ~/.vim
[ -f ~/.vimrc ] && rm ~/.vimrc
[ -f ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf ] && rm ~/Library/Fonts/DroidSansMonoForPowerlineNerdFontComplete.otf

echo 'Done.';

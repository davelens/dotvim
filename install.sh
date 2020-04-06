#!/bin/sh

# Stops further execution after any error.
set -e

ln -s ${HOME}/.dotvim/config/nvim ${HOME}/.config/nvim
ln -s ${HOME}/.dotvim/vim ${HOME}/.vim
ln -s ${HOME}/.dotvim/vimrc ${HOME}/.vimrc

echo 'Done.'

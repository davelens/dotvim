#!/bin/sh

# Stops further execution after any error.
set -e

[ ! -d ${HOME}/.config ] && mkdir ${HOME}/.config
[ ! -d ${HOME}/.local/bin ] && mkdir -p ${HOME}/.local/bin

[ ! -f ${HOME}/.config/nvim ] && ln -s ${HOME}/.dotvim/config/nvim ${HOME}/.config/nvim
[ ! -f ${HOME}/.config/dvim ] && ln -s ${HOME}/.dotvim/config/dvim ${HOME}/.config/dvim
[ ! -d ${HOME}/.vim ] && ln -s ${HOME}/.dotvim/vim ${HOME}/.vim
[ ! -f ${HOME}/.vimrc ] && ln -s ${HOME}/.dotvim/vimrc ${HOME}/.vimrc

if [ ! -f ${HOME}/.local/bin/dvim ]; then
  cat >> ${HOME}/.local/bin/dvim<< EOF
#!/usr/bin/env bash

export NVIM_APPNAME="$\{NVIM_APPNAME:-"dvim"\}"
exec -a "\$NVIM_APPNAME" nvim -u "~/.config/dvim/init.lua" "\$@"

echo 'Done.'
EOF
  chmod +x ${HOME}/.local/bin/dvim
fi

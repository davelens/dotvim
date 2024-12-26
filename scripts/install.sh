#!/bin/sh

# Stops further execution after any error.
set -e

SCRIPT_DIR=$(dirname "$(realpath "$0")")

source ${SCRIPT_DIR}/helpers.sh

[ ! -d ${HOME}/.local/bin ] && mkdir -p ${HOME}/.local/bin

# Check if ~/.local/bin is in $PATH so we can install getnf if necessary.
if [[ ! $(echo $PATH | tr ':' '\n' | grep -x "$HOME/.local/bin") ]]; then
  echo "$(cross) ERROR: ~/.local/bin needs to be in your \$PATH."
  exit
fi

echo "$(check) ~/.local/bin is in \$PATH"

if [ $(uname -s) == 'darwin' ]; then
  FONTS_DIR=${HOME}/Library/Fonts
else
  FONTS_DIR=${HOME}/.local/share/fonts
fi

# Install getnf if not already installed.
if [ ! -f ${HOME}/.local/bin/getnf ]; then
  curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
fi

echo "$(check) getnf is installed"

[ ! -d ${FONTS_DIR}/DroidSansMono ] && getnf -i DroidSansMono 
[ ! -d ${FONTS_DIR}/Hack ] && getnf -i Hack 

echo "$(check) Nerd fonts installed"

[ ! -d ${HOME}/.config ] && mkdir ${HOME}/.config
[ ! -d ${HOME}/.config/dvim ] && ln -s $(dirname ${SCRIPT_DIR}) ${HOME}/.config/dvim

echo "$(check) Symlinks are present in ~/.config"

if [ ! -f ${HOME}/.local/bin/dvim ]; then
  cat >> ${HOME}/.local/bin/dvim<< EOF
#!/usr/bin/env bash

export NVIM_APPNAME=\${NVIM_APPNAME:-"dvim"}
exec -a "\$NVIM_APPNAME" nvim -u "~/.config/dvim/init.lua" "\$@"

echo 'Done.'
EOF
  chmod +x ${HOME}/.local/bin/dvim
  echo "$(check) Created ~/.local/bin/dvim executable"
fi

echo "$(check) dvim successfully installed"
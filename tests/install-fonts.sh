#!/usr/bin/env bash
# Run with: bash tests/install-fonts.sh
set -e

source "$(dirname "${BASH_SOURCE[0]}")/../setup/install"

uname() { echo "$os"; }
check() { echo '[ok]'; }
warn() { echo '[warn]'; }
command() {
  if [[ "$*" == '-v fc-list' ]]; then
    return "$missing_fc_list"
  fi
  builtin command "$@"
}
is_font_installed() {
  if [[ "$os" == Linux && "$missing_fc_list" == 1 ]]; then
    echo 'Font detection must not run without fc-list' >&2
    exit 1
  fi
  return 0
}

for os in Linux Darwin; do
  for missing_fc_list in 0 1; do
    output=$(install_fonts)
    if [[ "$os" == Linux && "$missing_fc_list" == 1 ]]; then
      [[ "$output" == *'Skipping font installation'* ]]
    else
      [[ "$output" == *'All Nerd fonts already installed'* ]]
    fi
  done
done

echo 'Font prerequisite checks passed'

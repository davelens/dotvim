#!/bin/sh

check() {
  echo "[$(tput setaf 2)✓$(tput sgr0)]"
}

cross() {
  echo "[$(tput setaf 1)x$(tput sgr0)]"
}


check() {
  echo "[$(tput setaf 2)✓$(tput sgr0)]"
}

cross() {
  echo "[$(tput setaf 1)x$(tput sgr0)]"
}

warn() {
  echo "[$(tput setaf 3)!$(tput sgr0)]"
}


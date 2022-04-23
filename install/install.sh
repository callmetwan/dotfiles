#!/bin/bash

set -eo pipefail

export DOTFILES_LOCATION="${HOME}/dotfiles"
[[ "${1}" == "--debug" ]] && export DEBUG=1

if [[ ! -d "${DOTFILES_LOCATION}" ]]; then
  echo "No dotfiles repo found at: ${DOTFILES_LOCATION}"
  return 1
fi

echo "Copying bin files"
ln -sfn "${DOTFILES_LOCATION}/install/bin" "${HOME}/bin"
ln -sfn "${DOTFILES_LOCATION}/install/.config" "${HOME}/.config"

echo "Copying home files and .env files"
# Create individual links for each file within the DOTFILE/home directory and link them into the $HOME directory
# See this super useful resource on globbing: https://teaching.idallen.com/cst8207/12f/notes/190_glob_patterns.html
# Particularly:
#       rm -rf .??* to avoid matching '.' and '..'
ln -sfn ${DOTFILES_LOCATION}/home/.??* "${HOME}"    # Warning: This won't link files that do not begin with a '.'!
ln -sfn ${DOTFILES_LOCATION}/env/.env* "${HOME}"    # Warning: This won't link files that do not begin with a '.env'!

[[ ! -d "${HOME}/.vim/undodir" ]] && mkdir -p "${HOME}/.vim/undodir"

echo "Setting up environment post-install; sourcing $HOME/.env"
source "${HOME}/.env"

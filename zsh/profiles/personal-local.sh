#!/bin/zsh
scriptDir=$(dirname $0)
source "$scriptDir/base/macos.sh"

alias mrpop='cd ~/dev/misterpoppins'
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/Users/anthony/Library/Application Support/fnm:$PATH"
eval "`fnm env --use-on-cd`"

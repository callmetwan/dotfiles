#!/bin/zsh
scriptDir=$(dirname $0)
source "$scriptDir/base/default.sh"

# Navigation
alias kw="cd ~/dev/kazoo-web"
alias yei="cd ~/dev/web-legacy-rr"
alias hg='cd ~/dev/hgapp'

# coder shortcuts
alias cb="coder workspaces rebuild anthony-dev; coder workspaces watch-build anthony-dev"
alias cw="coder workspaces watch-build anthony-dev"

# fnm automatic evaluation
eval "$(fnm env --use-on-cd)"
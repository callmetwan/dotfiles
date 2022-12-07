#!/bin/bash

# Path to your oh-my-zsh installation.
export ZSH="/home/coder/.oh-my-zsh"

#Custom prompt symbol
export CUSTOM_PROMPT_SYMBOL=" ➜"

# Source default
scriptDir=$(dirname $0)
source "$scriptDir/default.sh"

# Navigation
alias kw="cd ~/kazoo-web"
alias yei="cd ~/web-legacy-rr"
alias hg='cd ~/hgapp'
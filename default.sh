#!/bin/bash

# The current directory this script is running in
scriptDir=$(dirname $0)

# Git
alias gs='git status'
alias gb='git_branch_advanced'
alias gl='git log'
alias glo='git log --oneline'
alias stat="gl -1 --stat"
alias gp='git pull'
alias gap='git add -p'
alias difftool="git difftool"
alias dtool="git difftool"
alias dt="git difftool"
alias gt="git difftool"
alias gc="git checkout ."
alias cm="git commit"
alias grr="git checkout master && git pull && git checkout - && git rebase master && git shove"
alias amend="git commit --amend --no-edit"
alias ammend="git commit --amend --no-edit"
alias amend-edit="git commit --amend"

# Utility
alias ll='ls -laGFh'
alias grep='grep --color=always'
alias vimrc='vim ~/.vimrc'
# TODO: Should we replace this with "exec bash -l"?
alias refresh='source ~/.bash_profile; source ~/.env'
alias edov="vim ~/.overloadrc" # This is the config file for overloading bash methods like "git" which I use to prompt if I've run mvn install before pushing
alias dotinstall="source ~/dotfiles/install/install.sh"


###### ZSH specific stuff
ZSH_DISABLE_COMPFIX=true
export CLICOLOR=1
export TERM=xterm-256color

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira-custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
 ZSH_CUSTOM="$scriptDir/oh-my-zsh-custom/"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#zsh-autosuggestions color fixing for solarized color scheme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

# I turned this on because it was a massive performance boost. See these threads:
# https://github.com/zsh-users/zsh-autosuggestions/issues/544
# https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
eval "$(fnm env --use-on-cd)"
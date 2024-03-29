#!/bin/zsh
# Path to your oh-my-zsh installation.
export ZSH="/Users/anthony/.oh-my-zsh"

# Source default
scriptDir=$(dirname $0)
source "$scriptDir/default.sh"


# PATH
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/.local/bin:/sbin:~/bin:/Users/anthony/.composer/vendor/bin:/Users/anthony/dev/scripts:PATH"
export PATH=$PATH:"/Users/anthony/.platformio/penv/bin"

# Alias
alias sublime="subl"

# Navigation
alias kw="cd ~/dev/kazoo-web"
alias yei="cd ~/dev/web-legacy-rr"
alias hg='cd ~/dev/hgapp'
alias mrpop='cd ~/dev/misterpoppins'

# Quick open
alias pr='gh pr create -w' # Create a PR on GitHub opening in a new tab
alias cg='git rev-parse --abbrev-ref HEAD | tr -d "\n" | pbcopy'
alias zshconfig="subl ~/.zshrc"
alias zconfig="subl ~/.zshrc"
alias dev="/Users/anthony/dev"
alias hosty="subl /etc/hosts"
alias screensaver="sudo open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"


# Restart services
alias cb="coder workspaces rebuild anthony-dev; coder workspaces watch-build anthony-dev"
alias cw="coder workspaces watch-build anthony-dev"
alias flushdns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias restartspotlight="killall Spotlight"
alias imgdim='sips -g pixelHeight -g pixelWidth $1'
alias fix-audio='sudo killall -9 coreaudiod'
alias fix-node='killall node' #used to fix a React node process that won't let go
alias fix-dock='killall Dock'

# rust lang
export PATH="$HOME/.cargo/bin:$PATH"

# React Native Android dev requirements
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/openssl/bin:$PATH"
export REACT_EDITOR="subl"
export REACT_DEBUGGER="open -g 'rndebugger://set-debugger-loc?port=8081' || react-native start"

#### Adam's original stuff I'm not using
alias lunch='cd ~/code/lunchline'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias resetMessages="killall Messages && killall Dock && open -a Messages"
alias ag="ag --ignore-dir={Library,Photos,Pictures}"
alias moon="vim ~/qmk_firmware/keyboards/moonlander/keymaps/odyssey/keymap.c"
alias makemoon="cd ~/qmk_firmware; make moonlander:odyssey; cp .build/moonlander_odyssey.bin ~/Downloads/moonlander_odyssey_latest.bin; ~/Downloads/wally-cli ~/Downloads/moonlander_odyssey_latest.bin; cd -"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Below are for Google Cloud utilities i.e. gsutil
# Multithreading has an issue in Python 3.8, use 3.7 for gsutil
export CLOUDSDK_PYTHON=/usr/local/opt/python@3.7/bin/python3
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

#eval "$(pyenv init -)"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anthony/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/anthony/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anthony/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/anthony/google-cloud-sdk/completion.zsh.inc'; fi
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/application_default_credentials.json

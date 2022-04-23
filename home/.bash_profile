#!/bin/bash

if [[ "${DOT_ENV_CONFIGURED}" != "1" ]]; then
    echo "No .env sourced yet. Attempting that now."
    source "${HOME}/.env"
    if [[ -z "${DOT_ENV_CONFIGURED}" ]]; then
        echo "$DOT_ENV_CONFIGURED"
        echo "Error configuring environment. Stopping bash_profile sourcing"
        return 1
    else
        echo "Successfully activated the ${INSTALL_ENV} environment"
    fi
fi

# Check if tty is a terminal
if [[ -t 1 ]]; then
    # Do not allow Ctrl-s to freeze the terminal
    # https://unix.stackexchange.com/a/12108
    stty -ixon
    # Remove the Ctrl-s binding in bash
    bind -r '\C-s'
fi

# If the shell isn't interactive, we'll make it so and set a variable so
# we don't keep looping between sourcing both of these shells.
if [[ "${-}" != *"i"* ]] && [[ "${INTERACTIVE_SHELL}" != "1" ]]; then
    export INTERACTIVE_SHELL=1
    source "${HOME}/.bashrc"
fi

# Ensure that vim's undo dir exists so that persistent_undo is available!
# Vim's persistent undo allows you to press 'u' even after coming into a
# new session in order to reverse changes.
if [[ ! -d "${HOME}/.vim/undodir" ]]; then
	echo "You do not have an undodir. Creating one now."
	mkdir -p "${HOME}/.vim/undodir"
fi

#-----------------------------------------------------------#
#						Imports								#
#-----------------------------------------------------------#

# Source all files in the DOTFILES_LOCATION that end in .sh
for f in ${HOME}/dotfiles/source/*.sh ; do
    echo "Sourcing: ${DOTFILES_LOCATION}${f/$DOTFILES_LOCATION\///}"
    source "${DOTFILES_LOCATION}${f/$DOTFILES_LOCATION\///}";
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Allow aliases to be used even in non-interactive shells
shopt -s expand_aliases
# Append to your history file rather than otherwrite
shopt -s histappend

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anthonygarritano/google-cloud-sdk/path.bash.inc' ]; then . '/Users/anthonygarritano/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anthonygarritano/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/anthonygarritano/google-cloud-sdk/completion.bash.inc'; fi

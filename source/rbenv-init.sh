#!/usr/bin/env bash

#==============================================================================
# DESCRIPTION
#               Set up rbenv stuff for ruby to work locally. Mainly built this
#               for YEI. Probably best to get rid of it once we never do local
#               development on YEI anymore.
#
#==============================================================================

export PATH="${HOME}/.rbenv/shims:${PATH}"
export RBENV_SHELL=bash
rbenv_bash_file='/usr/local/Cellar/rbenv/1.1.2/libexec/../completions/rbenv.bash'
[[ -s "${rbenv_bash_file}" ]] && source "${rbenv_bash_file}"
command rbenv rehash 2>/dev/null

rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

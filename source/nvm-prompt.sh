#!/usr/bin/env bash

#==============================================================================
# DESCRIPTION
#           This prompt will make sure that we automatically "use" nvm whenever
#           we cd into a new directory with a .nvmrc file.
#
#==============================================================================

useNvmIfPresent() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi
  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'useNvmIfPresent'

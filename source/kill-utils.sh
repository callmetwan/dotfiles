#!/bin/bash

function _kill() {
  program_name="${1}"
  shift
	(ps auwwx | \
	 ag "${program_name}" | \
	 # ignore-dir is part of the overridden default ag command
	 # We don't want to accidentally kill our ag query; so ignore it
	 ag -v ignore-dir | \
	 awk '{print $2}' | \
	 # We pass to xargs because we might have multiple programs to kill
	 xargs -I{} kill {}) 2>/dev/null
}

function killAdobe() {
  _kill "adobe"
}

function killMSAutoUpdate() {
  _kill "Microsoft AutoUpdate.app"
}

export -f killMSAutoUpdate
export -f _kill

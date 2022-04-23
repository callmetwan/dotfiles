# Purpose
The purpose of the dotfiles repo is to slowly build, organize, and maintain a list of useful scripting tools to help
expedite different development tasks. It should be groomed over time with the purpose of slowly discovering and then
following best principles.

After cloning the repo, simply run the "install" script to write all the dotfile configurations to their proper place.
```shell
bash install/install.sh
```

# Explanation of directories

---

## aliases/
The aliases directory is composed of several `<env>.alias.sh` files which are to be sourced in their respective environment.

## cron/
The cron directory houses crons which (currently), are only run locally, but this may change in the future.

## env/
The env directory contains `.env.<env>` scripts which should be initialized when the shell is initially set up. They are
separated in general by coder/macos and then the general .env file which should always be loaded.

## home/
The home directory contains files that should be installed straight to the user's home directory.

## install/
The install directory contains the install script, and several subdirectories which will be installed inside the install
script. Each directory may potentially be handled differently. Additional details should be located within the README in
the corresponding directory.

## ios/
The ios directory contains scripts intended to be called via iOS Shortcuts (i.e. via SSH)

## lib/
The lib directory contains scripts and tools designed to be reused extensively within the various other bash scripts.
Typically these will not be user-facing scripts.

## run_once/
The run_once directory is a WIP and hasn't ever actually be run. Theoretically, the .macos script should be called when
initializing a brand new macbook. It attempts to set sane defaults. However, I've never used it. It should be scrutinized
heavily before being called.

## source/
The source directory contains scripts, functions, and other misc tools that are sourced IN EVERY SHELL. So keep the things
in this directory limited strictly to necessary tools that are used in the shell. Otherwise, see the lib/ directory.

---

## Subcommands (in the `/bin` dir)
Subcommand idea came from [here](https://stackoverflow.com/a/37257634/6535053).

Source subcommand files like so:
```
source ./<filename>
```

An example of subcommands can be found in the /bin/coder file.

This file is designed to allow for quick/easy rebuilding of a coder environment by running `coder rebuild` which isn't a real
coder command. We define the script to allow calling the **REAL** coder-cli, but also allowing for the `rebuild` subcommand.

---

## The `install/.config` directory
Currently, this directory only holds files/data related to karabiner

---

## brew-list
This file is just a list of things I'll need to install using homebrew on a fresh install

---


Happy hacking!


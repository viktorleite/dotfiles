#!/bin/bash

config_path="$HOME/.config/bash"
source $config_path/.bash_aliases
source $config_path/.bash_prompt
source $config_path/.bash_functions
source $config_path/.bash_exports

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_competion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

#export PATH="./bin:$HOME/.local/bin:$PATH"

set +h

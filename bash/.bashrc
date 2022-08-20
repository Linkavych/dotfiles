# Bootstrap
# If not interactive, do nothing
if [[ $- != *i* ]] ; then
    return
fi

# Basic Setup
export PAGER=less
export MANPAGER=less

# Set the editor
export EDITOR=nvim
export VISUAL=nvim

# Ignore duplicate lines, or lines
# starting with space from history
HISTOCONTROL=ignoreboth

#--------------------#
#       shopt(s)     #
#--------------------#
# Append to history
shopt -s histappend
# Change to named directory
shopt -s autocd
# Autocorrect cd misspellings
shopt -s cdspell
# Save multiline commands in history as one line
shopt -s cmdhist
# Expand aliases
shopt -s expand_aliases
# include hidden files
shopt -s dotglob

# Hist file size
HISTSIZE=10000
HISTFILESIZE=2000

# Check window size
shopt -s checkwinsize

# Setting the Path
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "$HOME/.bin" ]]; then
    PATH="$HOME/.bin:$PATH"
fi

# Sourcing aliases
if [[ -f ~/.aliases ]]; then
    . ~/.aliases
fi
# Color prompt
force_color_prompt=yes

if [[ -n $force_color_prompt ]]; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Enable bash completion
if [[ -f /usr/share/bash-completion/bash_completion.sh ]]; then
    source /usr/share/bash-completion/bash_completion.sh
fi

# ssh-agent stuff
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# PLUGINS
# Extractor Function
# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# fzf
if [[ -d '/usr/share/examples/fzf' ]]; then
    source /usr/share/examples/fzf/shell/completion.bash
    source /usr/share/examples/fzf/shell/key-bindings.bash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf command exports
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Starship Prompt
eval "$(starship init bash)"

# Rust Stuff
. "$HOME/.cargo/env"

# API Stuff for malware
source ~/.config/malware.sh

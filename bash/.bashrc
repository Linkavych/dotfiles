# Bootstrap
# Don't clobber the things
set -o noclobber

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
HISTSIZE=90000
HISTFILESIZE=20000

# History time format
# UNIX YEAR-MO-DAY HR:MIN:SEC-TZ
HISTTIMEFORMAT="%s %F %R-%Z "

# Check window size
shopt -s checkwinsize

# Setting the Path
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$PATH:$HOME/.local/bin"
fi

if [[ -d "$HOME/.bin" ]]; then
    PATH="$PATH:$HOME/.bin"
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
      *.txz)       tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# URL Decoded strings
ud ()
{
  echo "[+] URL Decoded: $(echo -n $1 | sed 's/%/\\x/g')"
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

# API Stuff for malware
source ~/.config/malware.sh

# Resetting PATH
export PATH="$PATH:/home/linkavych/.cargo/bin:/usr/local/go/bin"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

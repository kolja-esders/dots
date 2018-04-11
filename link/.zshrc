# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mercurial extract zsh-syntax-highlighting tumult up k shrink-path)

# User configuration

#export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Shrink prompt
prompt_dir() {
  prompt_segment blue black "%-64<...<%~%<<"
}

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

include () {
    [[ -f "$1" ]] && source "$1"
}
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

alias gdc='git diff --cached'
alias zrc="nvim ~/.zshrc"
alias szrc="source ~/.zshrc"
alias vrc="nvim ~/.vimrc"
alias svrc="source ~/.vimrc"
alias vim="nvim"
alias v="nvim"
alias c="clear"
alias rmf="rm -rf"
alias fzi="sudo openvpn --config ~/.ssh/fzi-vpn.ovpn"
alias p3="python3"
alias p2="python2"
alias tn="tmux new -s"
alias ta="tmux attach -t"

if is_ubuntu; then
  alias o="xdg-open . &>/dev/null"
elif is_osx; then
  alias o='open .'
fi

dl() {
  youtube-dl "$1" --audio-format=mp3 --audio-quality=0 -x --verbose
}

# Source [ARG]/bin/activate
s() {
  source "$1"/bin/activate
}

# Easily switch iTerm profile
theme-switch () {
  clear
  echo -e "\033]50;SetProfile=$1\a";
  export ITERM_PROFILE=$1;
  [ $1 = light ] &&
     ZSH_THEME="agnoster-light" ||
     ZSH_THEME="agnoster"
  source $ZSH/oh-my-zsh.sh
}

[[ -f ~/.scripts/z.sh ]] && . ~/.scripts/z.sh
[[ -f /Applications/Postgres.app/Contents/Versions/latest/bin ]] && export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
[[ -f $PATH:/Applications/MATLAB_R2016b.app/bin ]] && export PATH=$PATH:/Applications/MATLAB_R2016b.app/bin

# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

####################################################################################################

# shortcut to this dotfiles path is $DOTS
export DOTS=$HOME/.dots

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
include ~/.localrc

##################################################################################################

# OpenVPN
export PATH="/usr/local/opt/openvpn/sbin:$PATH"

# CUDA
#export PATH="$PATH:/usr/local/cuda/bin"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/Users/kolja/Projects/aadc/robot_folders/checkout/oadrive/ic_workspace/export/lib"
#export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/Users/kolja/Projects/aadc/robot_folders/checkout/oadrive/ic_workspace/export/lib"

include ~/.fzf.zsh

# Flutter
export PATH="/Users/kolja/Projects/flutter/bin:$PATH"

# MASTER

include ~/Projects/master/robot_folders/bin/fzirob_source.sh
#include /opt/ros/kinetic/setup.zsh

# PugiXML path needed for custom CMake FindPugiXML script needed for liblanet installation
#export PUGIXML_HOME="/Users/kolja/Projects/aadc2017/pugixml-1.8"
# export CMAKE_PREFIX_PATH="/Users/kolja/Projects/aadc2017/pugixml-1.8:$CMAKE_PREFIX_PATH"

#export CMAKE_C_COMPILER="/usr/local/bin/gcc-7"
#export CMAKE_CXX_COMPILER="/usr/local/bin/g++-7"

#export CC="/usr/local/bin/gcc-7"
#export CXX="/usr/local/bin/g++-7"

#export GTSAM_DIR=""

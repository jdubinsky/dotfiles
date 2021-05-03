export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# User configuration

source ~/.fzf.zsh

alias ls='ls -lGH'
alias g='git'
alias gcleanupbr='g br | grep -v develop | grep -v master | xargs git branch -D'

export FZF_DEFAULT_COMMAND='rg --files --hidden'

plugins=(
    git
    osx
    python
    yarn
    tmux
    tmuxinator
    npm
    npx
    cp
    rails
    ruby
    vi-mode
    zsh-navigation-tools
)

ggrep() {
  git grep "$1"  -- './*' ":!$2"
}

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}

export TERM="screen-256color"
export EDITOR=nvim
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/projects/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/projects/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/projects/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/projects/google-cloud-sdk/completion.zsh.inc"; fi

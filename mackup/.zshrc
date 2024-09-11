# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

if [ -n "$SPIN" ]
then
    alias shopcd='cd ~/src/github.com/Shopify/shopify'
    alias shopu='update shopify--shopify'
    alias update_nvim='cd ~/dotfiles && ./setup.sh --update-nvim && cd -'
    alias tokenupdate='bundle config --global PKGS__SHOPIFY__IO "token:$(gsutil cat gs://dev-tokens/cloudsmith/shopify/gems/latest)"'
    export PATH="$(yarn global bin):$PATH"
    alias devr='dev up && dev restart --procs'
else
    export BUNDLE_PATH=$GEM_HOME
    # alias sqlopen="open mysql://root@$(spin info fqdn)"
    [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
    if [ -e /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

    [[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)

    [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    git
    gitfast
    macos
    docker
    docker-compose
    python
    # pyenv
    cp
    rails
    ruby
    tmux
    vi-mode
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration
DISABLE_AUTO_TITLE="true"

[ -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh  ] && source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh

alias zj='zellij'
alias ls='ls -lGH'
alias g='git'
alias gcleanupbr='g br | grep -v develop | grep -v master | xargs git branch -D'
alias gprune='git remote prune origin'

export FZF_DEFAULT_COMMAND='rg --files --hidden'

ggrep() {
  git grep "$1"  -- './*' ":!$2"
}

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}

export TERM="xterm-256color"
export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export PATH=$PATH:$(npm get prefix)/bin:/opt/homebrew/bin

[[ -x chruby ]] && chruby 3.2.2

if type atuin > /dev/null; then
  eval "$(atuin init zsh)"
fi

# Created by `pipx` on 2024-06-03 18:45:48
# export PATH="$PATH:/Users/jdubinsky/.local/bin"

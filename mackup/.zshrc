# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    git
    macos
    docker
    docker-compose
    python
    cp
    rails
    ruby
    vi-mode
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration

alias ls='ls -lGH'
alias g='git'
alias gcleanupbr='g br | grep -v develop | grep -v master | xargs git branch -D'
alias mspin='mosh spin@$(spin show shopify-b2b-checkout-bfcn -o fqdn)'

if [ -n "$SPIN" ]
then
    alias shopcd='cd ~/src/github.com/Shopify/shopify'
    alias shopu='update shopify--shopify'
    alias tokenupdate='bundle config --global PKGS__SHOPIFY__IO "token:$(gsutil cat gs://dev-tokens/cloudsmith/shopify/gems/latest)"'
    export PATH="$(yarn global bin):$PATH"
else
    # alias sqlopen="open mysql://root@$(spin info fqdn)"
    [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
    if [ -e /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

    [[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

    [[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)

    [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden'

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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


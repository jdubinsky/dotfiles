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
    tmux
    tmuxinator
    cp
    rails
    ruby
    vi-mode
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration

source ~/.fzf.zsh

alias ls='ls -lGH'
alias g='git'
alias gcleanupbr='g br | grep -v develop | grep -v master | xargs git branch -D'
if [ -n "$SPIN" ]
then
    alias shopcd='cd /src/github.com/shopify/shopify'
    alias tokenupdate='bundle config --global PKGS__SHOPIFY__IO "token:$(gsutil cat gs://dev-tokens/cloudsmith/shopify/gems/latest)"'
else
    alias nvim='/Users/jdubinsky/projects/dotfiles/nvim-osx64/bin/nvim'
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
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

spinservice() {
    spin info fqdn|awk -F '.' '{print $1}'
}

spinworkspace() {
    jq -j --exit-status .default_workspace_group ~/.spin/state.spin.up.dev.json
}

spinhost() {
    [[ $# -lt 2 ]] || { echo "usage: ${FUNCNAME[0]} [service]">&2 ; return; }
    local service=${1-$(spinservice)}
    local workspace="$(spinworkspace)"
    if ! spin list --output json|jq -j --exit-status --arg workspace "${workspace}" --arg service "${service}" '.Workspaces[] | select(.Name==$workspace).Services[$service].FQDN | values' ; then
        echo "Service '${service}.${workspace}' not found">&2
    fi
}

spinmount() {
    [[ $# -lt 2 ]] || { echo "usage: ${FUNCNAME[0]} [service]">&2 ; return; }
    local service=${1-$(spinservice)}
    local localPath="${HOME}/spin/${service}"
    local remotePath="/src/github.com/shopify/${service}"
    local host="$(spinhost "${service}")"
    [[ -n "${host}" ]] || return
    local remoteUrl="${host}:${remotePath}"
    mkdir -p "${localPath}"
    umount -f "${localPath}" 2>/dev/null
    echo "Mounting ${remoteUrl} to ${localPath}"
    sshfs "${remoteUrl}" "${localPath}"
}

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jdubinsky/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)

source ~/.fzf.bash

export PATH=/usr/local/bin:/Users/jdubinsky/.nvm/versions/node/v/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export BASH_CONF="bashrc"
export EDITOR=nvim

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ls='ls -lGH'
alias rmpyc='find . -name '.git' -prune -o -name '*.pyc' -exec rm {} \;'
alias g='git'
alias gcleanupbr='g br | grep -v develop | grep -v master | xargs git branch -D'

alias vim='nvim'
alias tmux='tmux -2'
alias tmn='tmux new -s'
alias tma='tmux a -t'
alias tmls='tmux ls'


complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}

fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || nvim "$file"
  fi
}

export PATH="$HOME/.yarn/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export LC_CTYPE=en_US.UTF-8

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/jdubinsky/projects/service-generator/test-jacob/node_modules/tabtab/.completions/serverless.bash ] && . /Users/jdubinsky/projects/service-generator/test-jacob/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/jdubinsky/projects/service-generator/test-jacob/node_modules/tabtab/.completions/sls.bash ] && . /Users/jdubinsky/projects/service-generator/test-jacob/node_modules/tabtab/.completions/sls.bash
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#!/bin/zsh

sudo apt-get install -y neovim

if ! command -v rg &> /dev/null; then
  sudo apt-get install -y ripgrep
fi

if ! command -v fzf &> /dev/null; then
  sudo apt-get install -y fzf
fi

ln -sf ~/dotfiles/mackup/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/mackup/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/mackup/.zshrc ~/.zshrc

nvim --headless +PlugInstall +qall

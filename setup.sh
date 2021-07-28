#!/bin/zsh

# install required packages
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
alias nvim="~/dotfiles/squashfs-root/usr/bin/nvim"

if ! command -v rg &> /dev/null; then
  sudo apt-get install -y ripgrep
fi

if ! command -v fzf &> /dev/null; then
  sudo apt-get install -y fzf
fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# gems
gem install solargraph
gem install ripper-tags
gem install sorbet
gem install neovim
gem install activesupport

# lsp
sudo npm install -g diagnostic-languageserver
sudo npm install -g typescript-language-server
sudo npm install -g graphql-language-service-cli

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# create dir structure for neovim
mkdir -p ~/.config/nvim/

# dotfiles
ln -sf ~/dotfiles/mackup/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/mackup/.zshrc ~/.zshrc

# install neovim plugins
nvim --headless +PlugInstall +qall

# reload with plugins
source ~/.zshrc

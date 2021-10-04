#!/bin/zsh

update_nvim_flag=false;

zparseopts -E -D -- -update-nvim=update_nvim_flag

if [ -n "$SPIN" ]
then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update
    sudo apt-get install neovim -y
else
    rm nvim-macos.tar.gz
    rm -rf ./nvim-osx64

    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz &&
        tar xvzf nvim-macos.tar.gz &&
        cp ./nvim-osx64/bin/nvim /usr/local/bin/nvim
fi

if [ -n "$update_nvim_flag" ]
then
    source ~/.zshrc
    echo "nvim udpated, exiting";
    exit;
fi

# install required packages
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
ln -sf ~/dotfiles/mackup/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/mackup/.zshrc ~/.zshrc

# install neovim plugins
nvim --headless +PlugInstall +qall

# reload with plugins
source ~/.zshrc

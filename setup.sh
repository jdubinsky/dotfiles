#!/bin/zsh

update_nvim_flag=false;

zparseopts -E -D -- -update-nvim=update_nvim_flag

rm nvim.appimage && rm -rf squashfs-root
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage &&
  chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract &&
  sudo cp -rp squashfs-root/usr/* /usr

if [ -n "$update_nvim_flag" ]
then
    source ~/.zshrc
    echo "nvim udpated, exiting";
    exit;
fi

# install required packages
if ! command -v rg &> /dev/null; then
  sudo apt-get install -y ripgrep
  sudo apt-get install -y fd
fi

sudo apt install -y fd-find

FZF_VERSION=0.35.1
wget https://github.com/junegunn/fzf/releases/download/$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tar.gz &&
  tar xvzf fzf-$FZF_VERSION-linux_amd64.tar.gz && sudo mv fzf /usr/local/bin/fzf

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Cousine.zip
mkdir -p ~/.local/share/fonts
unzip Cousine.zip -d ~/.local/share/fonts
rm ~/.local/share/fonts/*Windows*
rm Cousine.zip
fc-cache -fv

# gems
cd /home/spin/src/github.com/Shopify/web && gem install sorbet neovim activesupport

# lsp
npm install -g typescript-language-server graphql-language-service-cli eslint eslint_d

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# create dir structure for neovim
mkdir -p ~/.config/nvim/

# dotfiles
ln -sf ~/dotfiles/mackup/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/mackup/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.pryrc ~/.pryrc
ln -sf ~/dotfiles/.fdignore ~/.fdignore
ln -sf ~/dotfiles/mackup/.tmux.conf ~/.tmux.conf

# install neovim plugins
nvim --headless +PlugInstall +qall

git config --global commit.gpgSign true

# reload with plugins
source ~/.zshrc

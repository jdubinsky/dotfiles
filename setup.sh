#!/bin/bash

set -e

DOTFILES_DIR="$HOME/projects/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up dotfiles...${NC}"

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo -e "${YELLOW}Backup directory: $BACKUP_DIR${NC}"

# Function to backup and symlink
backup_and_link() {
  local src="$1"
  local dest="$2"

  # Backup existing file/directory if it exists and is not a symlink
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up $dest"
    mv "$dest" "$BACKUP_DIR/"
  elif [ -L "$dest" ]; then
    echo "Removing old symlink $dest"
    rm "$dest"
  fi

  # Create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  # Create symlink
  echo "Linking $src -> $dest"
  ln -sf "$src" "$dest"
}

# Backup and symlink dotfiles
echo -e "\n${GREEN}Creating symlinks...${NC}"

# Neovim
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Zsh
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.oh-my-zsh" "$HOME/.oh-my-zsh"

# Tmux
backup_and_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Atuin (shell history)
backup_and_link "$DOTFILES_DIR/atuin" "$HOME/.config/atuin"

# Git config (if exists)
if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
  backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
fi

echo -e "\n${GREEN}✓ Dotfiles setup complete!${NC}"
echo -e "${YELLOW}Backed up files are in: $BACKUP_DIR${NC}"
echo -e "\nRun 'source ~/.zshrc' to reload your shell configuration."

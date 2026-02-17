# Dotfiles

Personal configuration files for development environment.

## Structure

```
dotfiles/
├── nvim/          # Neovim configuration
├── atuin/         # Atuin (shell history) configuration
├── .zshrc         # Zsh shell configuration
├── .oh-my-zsh/    # Oh-My-Zsh custom files
├── .tmux.conf     # Tmux configuration
├── .gitconfig     # Git configuration
└── setup.sh       # Setup script
```

## Installation

Clone this repository and run the setup script:

```bash
git clone https://github.com/yourusername/dotfiles ~/projects/dotfiles
cd ~/projects/dotfiles
./setup.sh
```

The setup script will:
- Backup existing dotfiles to `~/.dotfiles-backup-<timestamp>`
- Create symlinks from your home directory to this repo
- Preserve your existing configurations

## What's Included

### Neovim
- Modern Neovim config with LSP, completion, and treesitter
- Plugin manager: lazy.nvim
- Keybindings for development workflow

### Zsh
- Oh-My-Zsh with custom plugins and themes
- Aliases and shell functions

### Tmux
- Terminal multiplexer configuration
- Custom keybindings

## Updating

To update your dotfiles, simply pull the latest changes:

```bash
cd ~/projects/dotfiles
git pull
```

Since your configs are symlinked, changes take effect immediately (reload shell with `source ~/.zshrc` if needed).

## Restoring

If you need to restore from backup:

```bash
# Find your backup directory
ls -la ~ | grep dotfiles-backup

# Restore files
cp -r ~/.dotfiles-backup-<timestamp>/.zshrc ~/
# etc...
```

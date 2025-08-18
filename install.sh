#!/bin/bash
# This script creates symlinks from the home directory to the dotfiles in this repository.
# It also backs up any existing dotfiles to a new directory.

# --- Configuration ---
# Directory where your dotfiles repository is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Directory to back up existing dotfiles
BACKUP_DIR=~/.dotfiles_backup_$(date +%Y-%m-%d_%H-%M-%S)

# List of files/folders to symlink
# Add all your config files here
FILES_TO_SYMLINK=(
  ".zshrc"
  ".p10k.zsh"
  ".tmux.conf"
  ".gitconfig"
  # Add other files like ".vimrc", ".config/nvim", etc.
)

# --- Script Execution ---
echo "🚀 Starting dotfiles setup..."

# Create backup directory
echo "📂 Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Loop through each file and create symlink
for file in "${FILES_TO_SYMLINK[@]}"; do
  source_file="$DOTFILES_DIR/configs/$file" # Assuming you'll store configs in a 'configs' subfolder
  target_file="$HOME/$file"

  # Check if the source file exists in your repo
  if [ ! -e "$source_file" ]; then
    echo "⚠️  Warning: Source file not found, skipping: $source_file"
    continue
  fi

  # If the target file already exists in the home directory, back it up
  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    echo "    -> Backing up existing $target_file to $BACKUP_DIR"
    mv "$target_file" "$BACKUP_DIR/"
  fi

  # Create the symlink
  echo "    -> Creating symlink for $file"
  ln -s "$source_file" "$target_file"
done

echo ""
echo "✅ Dotfiles setup complete!"
echo "➡️  Your original files are backed up in: $BACKUP_DIR"
echo "ℹ️  Please restart your shell (or run 'source ~/.zshrc') to apply changes."

#!/bin/bash
set -euo pipefail

# 📁 setting path
USB_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
GS42_DIR="$USB_DIR/gs42"
DOTFILES="$GS42_DIR/.dotfiles42"

# Add setup.sh
ZSH="${ZSH:-$USB_DIR/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH}/custom"

create_symlink() {
    local target=$1
    local link=$2
    [ -e "$link" ] || [ -L "$link" ] && rm -rf "$link"
    ln -sf "$target" "$link"
}

OHMYZSH_DIR="$USB_DIR/.oh-my-zsh"
ZOXIDE_DIR="$USB_DIR/.local/share/zoxide"

# 1. Install Oh My Zsh
if [ ! -d "$OHMYZSH_DIR" ]; then
  echo "📦 Oh My Zsh 설치 중..."
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OHMYZSH_DIR"
fi

# 1️⃣ zsh-autosuggestions
if [ ! -d "$USB_DIR/plugins/zsh-autosuggestions" ]; then
  echo "📦 zsh-autosuggestions 설치 중..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
fi

# 2️⃣ zsh-syntax-highlighting
if [ ! -d "$USB_DIR/plugins/zsh-syntax-highlighting" ]; then
  echo "📦 zsh-syntax-highlighting 설치 중..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
fi

# 3️⃣ powerlevel10k
if [ ! -d "$USB_DIR/themes/powerlevel10k" ]; then
  echo "🎨 powerlevel10k 설치 중..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" 2>/dev/null || true
fi

# 5️⃣ FZF
if [ ! -d "$USB_DIR/.fzf" ]; then
  echo "📦 fzf 설치 중..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$USB_DIR/.fzf"
  "$USB_DIR/.fzf/install" --bin --no-update-rc
else
  echo "✅ fzf 이미 설치됨"
fi

if [ ! -d "$USB_DIR/.tmux" ]; then
  echo "📦 fzf 설치 중..."
  git clone https://github.com/tmux-plugins/tpm "$USB_DIR/.tmux/plugins/tpm"
else
  echo "✅ tpm 이미 설치됨"
fi

echo "✅ 필요한 도구 설치 완료!"

# 🔗 USB 루트 dotfiles 심볼릭 링크
create_symlink "$USB_DIR/bat"       ~/bat
create_symlink "$USB_DIR/.fzf"      ~/.fzf
create_symlink "$USB_DIR/.fzf.bash" ~/.fzf.bash
create_symlink "$USB_DIR/.fzf.zsh"  ~/.fzf.zsh
create_symlink "$USB_DIR/.npm"      ~/.npm
create_symlink "$USB_DIR/.tmux"     ~/.tmux

# 🔗 .dotfiles42 항목 링크
create_symlink "$DOTFILES/.tmux.conf" ~/.tmux.conf
create_symlink "$DOTFILES/.vimrc"     ~/.vimrc
create_symlink "$DOTFILES/.zshrc"     ~/.zshrc

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
MESLO_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip"

# 🔤 Meslo Nerd Font 설치
echo "🔤 Meslo Nerd Font 설치 중..."
cd "$FONT_DIR"
wget -q "$MESLO_URL" -O Meslo.zip
unzip -o Meslo.zip
rm Meslo.zip
fc-cache -fv > /dev/null

chmod +x /home/minjkang/goinfre/SanDisk/gs42/bin/zoxide

# ✅ Complete
echo -e "\n✅ 모든 설정 완료! 터미널 재시작 후 적용됩니다."

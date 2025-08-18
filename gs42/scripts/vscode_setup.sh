#!/bin/bash
set -euo pipefail

VSCODE_DIR="$HOME/goinfre/SanDisk/gs42/vscode"
USER_DIR="$HOME/.config/Code/User"

mkdir -p "$USER_DIR"

ln -sf "$VSCODE_DIR/settings.json" "$USER_DIR/settings.json"
ln -sf "$VSCODE_DIR/keybindings.json" "$USER_DIR/keybindings.json"

if [ -f "$VSCODE_DIR/extensions.txt" ]; then
  cat "$VSCODE_DIR/extensions.txt" | xargs -n 1 code --install-extension
fi

echo "✅ VSCode 설정 및 확장 복원 완료!"


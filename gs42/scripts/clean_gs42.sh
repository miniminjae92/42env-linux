#!/bin/bash

echo "🧹 Zsh 캐시 파일(.zcompdump*, .zwc) 삭제 시작..."

# 삭제 대상: 홈 디렉토리 기준
TARGET_DIR="$HOME"

# 삭제 실행
find "$TARGET_DIR" -maxdepth 1 \( -name ".zcompdump*" -o -name "*.zwc" \) -exec rm -v {} \;

echo "✅ 삭제 완료"

rm -rf ~/.cache/*
rm -rf ~/.local/state/*

rm -rf ~/.local/share/nvim/{backup,undo}/* 2>/dev/null

rm -rf ~/.local/share/nvim

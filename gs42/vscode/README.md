# VSCode 설정 경량화 및 백업 전략 (for 42 Ecole)

## ✅ 목적

VSCode의 무거운 설정/확장 데이터가 클러스터 환경에서 용량을 차지하지 않도록 하고,
클론만으로 내 개발환경을 복원할 수 있도록 만든다.

---

## 📁 저장소 구조 (`gs42/vscode`)

```
/gs42
└── vscode
    ├── settings.json         # VSCode 사용자 설정
    ├── keybindings.json      # 단축키 설정
    └── extensions.txt        # 설치한 확장 목록
    └── setup_vscode.sh       # 자동 복원용 스크립트
```

---

## ⚙️ 설정 백업 방법

```bash
# 현재 설정 백업
cp ~/.config/Code/User/settings.json ~/goinfre/SanDisk/gs42/vscode/
cp ~/.config/Code/User/keybindings.json ~/goinfre/SanDisk/gs42/vscode/
code --list-extensions > ~/goinfre/SanDisk/gs42/vscode/extensions.txt
```

---

## 🔗 설정 자동 적용 (.zshrc에 추가)

```zsh
# VSCode 설정 심볼릭 링크
ln -sf ~/goinfre/SanDisk/gs42/vscode/settings.json ~/.config/Code/User/settings.json
ln -sf ~/goinfre/SanDisk/gs42/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

---

## 🔁 확장 재설치 (필요 시)

```bash
cat ~/goinfre/SanDisk/gs42/vscode/extensions.txt | xargs -n 1 code --install-extension
```

---

## 🛠️ 자동 셋업 스크립트 (`setup_vscode.sh`)

```bash
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
```

실행 권한 부여:

```bash
chmod +x ~/goinfre/SanDisk/gs42/vscode/setup_vscode.sh
```

실행:

```bash
bash ~/goinfre/SanDisk/gs42/vscode/setup_vscode.sh
```

---

## ✅ 요약 (Feynman)

* 설정은 `gs42`에서 관리한다
* 무거운 확장은 클러스터에 남겨두거나 필요 시 다시 설치한다
* `.zshrc` 또는 `setup_vscode.sh` 중 하나로 설정 복원 가능

> "설정은 백업하고, 무거운 건 필요할 때만 불러오자."

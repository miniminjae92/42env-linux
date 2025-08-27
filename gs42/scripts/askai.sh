#!/bin/bash

# 스크립트에 파일 인자가 주어졌는지 확인합니다.
if [ $# -eq 0 ]; then
  echo "사용법: $0 [파일1] [파일2] ... 또는 $0 *.c"
  exit 1
fi

# 출력을 임시로 저장할 변수 선언
output_content=""

# AI 컨텍스트 추가
output_content+="아래는 제가 작업 중인 소스 코드 파일들의 내용입니다. 이 코드들에 대해 질문이 있습니다.\n"
output_content+="==================================================\n\n"

# 입력받은 모든 파일에 대해 반복
for file in "$@"
do
  if [ -f "$file" ] && [ -r "$file" ]; then
    output_content+="--- 파일명: $file ---\n"
    # `cat`의 결과를 변수에 추가
    output_content+=$(cat "$file")
    output_content+="\n--- $file 끝 ---\n\n"
  else
    # 터미널에는 경고 메시지 표시
    echo "경고: '$file' 파일을 찾을 수 없거나 읽을 수 없습니다." >&2
  fi
done

output_content+="==================================================\n"
output_content+="질문: "

# 운영체제에 맞는 클립보드 명령어를 찾아 실행
if command -v pbcopy &> /dev/null; then
  # macOS
  echo -n "$output_content" | pbcopy
  echo "✅ 프롬프트가 macOS 클립보드에 복사되었습니다."
elif command -v wl-copy &> /dev/null; then
  # Linux (Wayland)
  echo -n "$output_content" | wl-copy
  echo "✅ 프롬프트가 Wayland 클립보드에 복사되었습니다."
elif command -v xclip &> /dev/null; then
  # Linux (X11)
  echo -n "$output_content" | xclip -selection clipboard
  echo "✅ 프롬프트가 X11 클립보드에 복사되었습니다."
elif command -v clip.exe &> /dev/null; then
  # Windows (WSL)
  echo -n "$output_content" | clip.exe
  echo "✅ 프롬프트가 Windows 클립보드에 복사되었습니다."
else
  # 클립보드 도구가 없는 경우, 그냥 터미널에 출력
  echo "클립보드 도구를 찾을 수 없습니다. 터미널에 내용을 출력합니다:"
  echo -e "$output_content"
fi

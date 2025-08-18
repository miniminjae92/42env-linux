# Setup fzf
# ---------
if [[ ! "$PATH" == */home/minjkang/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/minjkang/.fzf/bin"
fi

source <(fzf --zsh)

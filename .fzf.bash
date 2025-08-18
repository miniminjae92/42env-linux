# Setup fzf
# ---------
if [[ ! "$PATH" == */home/minjkang/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/minjkang/.fzf/bin"
fi

eval "$(fzf --bash)"

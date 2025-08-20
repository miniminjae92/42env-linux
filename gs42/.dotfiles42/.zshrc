if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export USB="$(cd "$(dirname "$0")"/../.. && pwd)"
export GS42="$USB/gs42"
export ZSH="$USB/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export PATH="$GS42/bin:$PATH"

alias nvim="$GS42/bin/nvim"
export VIMRUNTIME="$GS42/tools/nvim/nvim-linux-x86_64/share/nvim/runtime"
export XDG_CONFIG_HOME="$GS42/.dotfiles42"  # .config 경로 수정
export XDG_DATA_HOME="$HOME/.local/share"  # .local 경로 수정
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"  # .cache 경로 수정

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting) 
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# VSCode 설정 심볼릭 링크
ln -sf ~/goinfre/SanDisk/gs42/vscode/settings.json ~/.config/Code/User/settings.json
ln -sf ~/goinfre/SanDisk/gs42/vscode/keybindings.json ~/.config/Code/User/keybindings.json

# User configuration

# ---- FZF -----

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# source "$GS42/tools/fzf-git.sh"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----
#alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"
alias cl="clear"

tmux_index_reset() {
  local n=0
  tmux list-windows -F '#I' | sort -n | while read i; do
    n=$((n+1))
    tmux move-window -s $i -t $n
  done
}
alias tir='tmux_index_reset'

# 42 projects needs functions

alias norm="norminette"

# Gemini CLI Settings
export PATH="/home/minjkang/42cluster/my_nodejs/node-v22.17.0-linux-x64/bin:$PATH"
if [ -f "$USB/.gemini.env" ]; then
	source "$USB/.gemini.env"
	export GOOGLE_API_KEY
fi

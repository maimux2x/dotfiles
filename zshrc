function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# ghq for gentoo
function fzf-ghq-cd() {
   local repo=$(ghq list | fzf)
   if [[ -n "$repo" ]]; then
     cd "$(ghq root)/$repo"
     zle reset-prompt
   fi
 }
 zle -N fzf-ghq-cd
 bindkey '^g' fzf-ghq-cd

# gitプロンプト表示
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプトカスタマイズ
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

# Go 開発環境
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# PostgreSQL 16 (Homebrew)
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# デフォルトエディタを Neovim に固定
export EDITOR=nvim

# mise
path=(
  $HOME/.local/bin
  $path
)

eval "$(mise activate zsh)"

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  last-working-dir
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
setopt inc_append_history
setopt inc_append_history_time
setopt hist_ignore_all_dups

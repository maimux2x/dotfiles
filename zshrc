# ghq
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

# Rust のツールチェイン管理ツール rustup が生成した初期化スクリプトを読み込む
. "$HOME/.cargo/env"

# OpenJDK 17 など のバイナリを先頭に追加し、java, javac コマンドでそのバージョンが優先されるように設定
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# デフォルトエディタを Neovim に固定
export EDITOR=nvim

# history
setopt share_history
setopt inc_append_history
setopt inc_append_history_time
setopt hist_ignore_all_dups

# mise
eval "$(mise activate zsh)"

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

# .envrc を自動ロード／アンロード
eval "$(direnv hook zsh)"

# Rust のツールチェイン管理ツール rustup が生成した初期化スクリプトを読み込む
. "$HOME/.cargo/env"

# OpenJDK 17 など のバイナリを先頭に追加し、java, javac コマンドでそのバージョンが優先されるように設定
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

デフォルトエディタを Neovim に固定
export EDITOR=nvim

# history
setopt share_history
setopt inc_append_history
setopt inc_append_history_time
setopt hist_ignore_all_dups

# NVM（Node Version Manager）周り
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Terraform など bash 補完しか提供しないツールを zsh でも補完可能
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  last-working-dir
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

eval "$(fzf --zsh)"
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

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
setopt inc_append_history
setopt inc_append_history_time
setopt hist_ignore_all_dups

zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|ls|rm|rmdir)($| )" ]]
}

# mise
PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate zsh)"

## zeno.zsh
export ZENO_HOME=~/.config/zeno
source $HOME/Documents/Source/github.com/yuki-yano/zeno.zsh/zeno.zsh

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' '  zeno-auto-snippet

  bindkey '^m' zeno-auto-snippet-and-accept-line

  bindkey '^i' zeno-completion

  bindkey '^xx' zeno-insert-snippet

  bindkey '^x '  zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet
fi

# 環境ごとの設定
case $OSTYPE in
  linux*)
    export PGUSER=postgres
  ;;
  darwin*)
    export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

    export EDITOR=nvim
    alias vi=nvim
  ;;
esac

autoload -Uz zmv
alias zmv='noglob zmv -W'

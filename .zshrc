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

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

eval "$(direnv hook zsh)"

. "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export EDITOR=nvim

# history
setopt share_history
setopt inc_append_history
setopt inc_append_history_time
setopt hist_ignore_all_dups


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/maimux2x/.opam/opam-init/init.zsh' ]] || source '/Users/maimux2x/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
eval "$(/Users/maimu/.local/bin/mise activate zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

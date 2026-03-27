# zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# alias
export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
export XDG_CONFIG_HOME="$HOME/.config"
export EZA_CONFIG_DIR="$HOME/.config/eza"
repos() {
  local repo
  repo="$(zoxide query --list | while read -r dir; do
    [ -d "$dir/.git" ] && echo "${dir/$HOME/~}"
  done | fzf --preview "git -C \$(echo {} | sed 's|~|$HOME|') log -n 200 --pretty=medium --all --graph --color=always")"

  [ -z "$repo" ] && return
  repo="${repo/#\~/$HOME}"

  local file
  file="$(cd "$repo" && fzf --preview "bat --color=always {}")"

  [ -n "$file" ] && nvim "$repo/$file"
}
alias c="clear"
alias ls='eza -l --icons --git -a --no-user --time-style=iso'
alias lt='eza --tree --level=2 -l --icons --git -a --no-user --time-style=iso'
alias vim="nvim"
alias vi="nvim"
alias vo="nvim -O"

# vi motions
set -o vi
# set for faster escape key 
KEYTIMEOUT=1

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

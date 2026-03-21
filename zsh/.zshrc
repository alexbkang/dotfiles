# zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# alias
cl() {
  if [ $# -eq 0 ]; then
    cd ~ || return
  else
    cd "$@" || return
  fi
  eza -l --icons --git -a --no-user --time-style=iso
}
alias ls='eza -l --icons --git -a --no-user --time-style=iso'
alias lt='eza --tree --level=2 -l --icons --git -a --no-user --time-style=iso'
alias vim="nvim"
alias vi="nvim"

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

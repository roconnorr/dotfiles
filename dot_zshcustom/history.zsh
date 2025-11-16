## ATUIN - Enhanced shell history
# Atuin replaces your existing shell history with a SQLite database
# and offers fully encrypted synchronization

# Initialize atuin
eval "$(atuin init zsh)"

# Enable up-arrow search in atuin
# This makes the up arrow search through history with the current command prefix
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget

# Syntax highlighting (keep existing configuration)
if [ -z "$HOMEBREW_PREFIX" ]
then
      source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
      source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

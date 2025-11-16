## ATUIN - Enhanced shell history
# Atuin replaces your existing shell history with a SQLite database
# and offers fully encrypted synchronization

# Initialize atuin (Ctrl+R for atuin UI, up arrow keeps default behavior)
eval "$(atuin init zsh)"

# Syntax highlighting (keep existing configuration)
if [ -z "$HOMEBREW_PREFIX" ]
then
      source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
      source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

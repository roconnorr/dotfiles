# Initialize atuin
eval "$(atuin init zsh)"

if [ -z "$HOMEBREW_PREFIX" ]
then
      source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
      source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

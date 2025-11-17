# Initialize atuin after zsh-vi-mode to ensure keybindings work
# Ctrl+R opens atuin UI, up arrow keeps default behavior
zvm_after_init() {
  eval "$(atuin init zsh --disable-up-arrow)"
}

# Fallback if zsh-vi-mode is not loaded
if ! typeset -f zvm_after_init_commands &>/dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

if [ -z "$HOMEBREW_PREFIX" ]
then
      source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
      source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#!/bin/bash
# script to set up a new macos machine

# Install Homebrew
if ! which -s brew;
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# Install Rust
if ! which -s cargo;
then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
    echo "Rust is already installed."
fi

echo "init chezmoi"
brew install chezmoi
chezmoi init --apply --verbose https://github.com/roconnorr/dotfiles.git

# install homebrew packages based on machine type
echo "What kind of machine is this? (work|home|base|none) "
read -r "answer?"

case $answer in
    [work]* ) echo "Installing base+work Brewfiles"; cat Brewfile.base Brewfile.work | brew bundle install --file=-;;
    [work]* ) echo "Installing base+home Brewfiles"; cat Brewfile.base Brewfile.home | brew bundle install --file=-;;
    [base]* ) echo "Installing base Brewfile"; brew bundle install --file=Brewfile.base;;
    * ) echo "Skipping Brewfile install";;
esac

# install oh-my-zsh
OMZDIR=~/.oh-my-zsh
if [ -d "$OMZDIR" ]; then
    echo "oh-my-zsh is already installed"
else 
    echo "oh-my-zsh not installed - installing"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # remove template file
    rm .zshrc.pre-oh-my-zsh
    chezmoi apply
fi

# fix shell completion permissions
compaudit | xargs chmod g-w,o-w

# apple tweaks
# Screenshots directory
mkdir ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# Prefer finder list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show library folder
chflags nohidden ~/Library

# Show appswitcher on all displays
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock

source ~/.zshrc

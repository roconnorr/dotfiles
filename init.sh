#!/bin/bash
# script to set up a new macos machine

# Install Homebrew
if ! which -s brew;
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "init chezmoi"
brew install chezmoi
# todo: point this repo at ssh instead of https
chezmoi init https://github.com/roconnorr/dotfiles.git
chezmoi apply

# install homebrew packages
brew bundle install

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
# Show appswitcher on all displays
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock

source ~/.zshrc

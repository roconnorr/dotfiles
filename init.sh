#!/bin/bash

# set up a new machine
# todo: install hammerspoon

# homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "init chezmoi"
brew install chezmoi
chezmoi init https://github.com/roconnorr/dotfiles.git
chezmoi apply

# install homebrew packages
brew bundle install

# check if its installed already
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# remove template
rm .zshrc.pre-oh-my-zsh
chezmoi apply

source ~/.zshrc

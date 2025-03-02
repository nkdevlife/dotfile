#!/usr/bin/env bash

set -eu

cd $HOME

# env
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

# brew
if ! type brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# git
if ! type git >/dev/null 2>&1; then
    brew install git
fi

# dotfiles
MY_ROOT_REPO=$HOME/ghq/github.com/nkdevlife

if [ ! -d "$MY_ROOT_REPO" ]; then
    mkdir -p "$MY_ROOT_REPO"
fi

MY_DOTFILE_REPO="$MY_ROOT_REPO"/dotfile

if [ ! -d "$MY_DOTFILE_REPO" ]; then
    git clone https://github.com/nkdevlife/dotfile.git "$MY_DOTFILE_REPO"
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# you-should-use
YOU_SHOULD_USE_DIR="${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}"/plugins/you-should-use

if [ ! -d "$YOU_SHOULD_USE_DIR" ]; then
	git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$YOU_SHOULD_USE_DIR"
fi

# brew install
if [[ $(brew list | wc -l) -ne 0 ]]; then
	brew update
	brew bundle --global
fi

# link
"$MY_DOTFILE_REPO"/script/link.sh

# setup
"$MY_DOTFILE_REPO"/script/setup.sh

source $HOME/.zshrc

# restart
read -p "Restart now? (y/N) " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo shutdown -r now
fi

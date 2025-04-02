#!/usr/bin/env bash

set -euo pipefail

# unlink
[[ -L $HOME/.config ]] && unlink $HOME/.config
[[ -L $HOME/.zshrc ]] && unlink $HOME/.zshrc
[[ -L $HOME/.zshenv ]] && unlink $HOME/.zshenv
[[ -L $HOME/.zprofile ]] && unlink $HOME/.zprofile
[[ -L $HOME/.Brewfile ]] && unlink $HOME/.Brewfile

# mise
if command -v mise &>/dev/null; then
  mise implode -y
fi

# Homebrew
if command -v brew &>/dev/null; then
  echo "uninstall Homebrew"
  sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
else
    echo "already uninstall Homebrew"
fi
[[ -e /opt/homebrew ]] && sudo rm -fr /opt/homebrew

# General
rm -fr $HOME/.cache

MY_DOTFILE_REPO="$HOME/ghq/github.com/nkdevlife/dotfile"

if [ -d "$MY_ROOT_REPO" ]; then
  rm -fr "$MY_ROOT_REPO"
fi

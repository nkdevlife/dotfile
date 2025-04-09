#!/usr/bin/env bash

set -euo pipefail

cd $HOME

echo '---------- install Rosetta ----------'
if /usr/bin/pgrep oahd >/dev/null 2>&1; then
  echo "skip installing Rosetta"
else
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi

echo '---------- clone dotfiles ----------'
MY_ROOT_REPO=$HOME/ghq/github.com/nkdevlife

if [ ! -d "$MY_ROOT_REPO" ]; then
  mkdir -p "$MY_ROOT_REPO"
fi

MY_DOTFILE_REPO="$MY_ROOT_REPO"/dotfile

if [ ! -d "$MY_DOTFILE_REPO" ]; then
  git clone https://github.com/nkdevlife/dotfile.git "$MY_DOTFILE_REPO"
else
  echo 'skip cloning git'
fi

# link
"$MY_DOTFILE_REPO"/script/link.sh

echo '---------- install Homebrew ----------'
if ! type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo 'skip installing Homebrew'
fi


echo '---------- install git ----------'
if ! type git >/dev/null 2>&1; then
  brew install git
else
  echo 'skip installing git'
fi


# brew install
if [ -f "$HOME/.Brewfile" ]; then
  brew update
  brew bundle --global
fi

# setup
"$MY_DOTFILE_REPO"/script/setup.sh

# night shift
# "$MY_DOTFILE_REPO"/script/night-shift.sh

# restart
read -p "Restart now? (y/N) " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
  sudo shutdown -r now
fi

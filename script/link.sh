#!/usr/bin/env bash

set -euo pipefail

# dotfilesディレクトリのパスを取得
DOTFILE_ROOT=$(cd "$(dirname "$0")/.." && pwd)

# バックアップ
BACKUP_DIR="$HOME/.backup.conf"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

cd "${DOTFILE_ROOT}"/dotfiles

for FILE in .??*; do
    [ "${FILE}" = ".git" ] && continue
    [ "${FILE}" = ".gitignore" ] && continue
    [ "${FILE}" = ".DS_Store" ] && continue

    SRC="${DOTFILE_ROOT}/dotfiles/${FILE}"
    DEST="${HOME}/${FILE}"

    if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
        mv -b "$DEST" "$BACKUP_DIR"
    fi

    ln -snfv "${SRC}" "${DEST}"
done

cd $HOME

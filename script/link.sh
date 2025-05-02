#!/usr/bin/env bash

set -euo pipefail

# dotfilesディレクトリのパスを取得
DOTFILE_ROOT=$(cd "$(dirname "$0")/.." && pwd)

# バックアップ
BACKUP_DIR="$HOME/.dotfiles_backup"

mkdir -p "$BACKUP_DIR"

cd "${DOTFILE_ROOT}"/dotfiles

for FILE in .??*; do
    [ "${FILE}" = ".git" ] && continue
    [ "${FILE}" = ".gitignore" ] && continue
    [ "${FILE}" = ".DS_Store" ] && continue

    SRC="${DOTFILE_ROOT}/dotfiles/${FILE}"
    DEST="${HOME}/${FILE}"

    if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
        mv "$DEST" "$BACKUP_DIR/${FILE}_$(date +%Y%m%d%H%M%S)"
    fi

    ln -snfv "${SRC}" "${DEST}"
done

cd $HOME

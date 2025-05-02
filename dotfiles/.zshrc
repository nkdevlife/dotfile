# ロケール設定（日本語 UTF-8 を有効にする）
export LANG=ja_JP.UTF-8

# XDG Base Directory の定義（設定ファイルやキャッシュの保存場所を整理）
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

# プロンプト設定を外部ファイルから読み込む
source "$HOME/.config/zsh/zsh-prompt-setup.sh"

# エイリアス設定を外部ファイルから読み込む
source "$HOME/.config/zsh/alias.zsh"


# =============================
# zsh config
# =============================

# ========== 履歴設定 ==========
# 環境変数名補完時に「=」を含められるようにする
setopt AUTO_PARAM_KEYS

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history
# メモリに保持する履歴数
export HISTSIZE=1000000
# ファイルに保存する履歴数
export SAVEHIST=1000000

# 他シェルと履歴をリアルタイムで共有
setopt share_history
# 同じコマンドの重複記録を防ぐ
setopt hist_ignore_dups
# 開始・終了時間を記録
setopt EXTENDED_HISTORY
# 古いコマンドと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンドを記録しない（意図的な一時コマンドに便利）
setopt hist_ignore_space
# 履歴呼び出し後に編集可能にする
setopt hist_verify
# 余計な空白を削除
setopt hist_reduce_blanks
setopt hist_save_no_dups
# 実行と同時に履歴を保存
setopt inc_append_history

# 日本語ファイル名などを正しく表示
setopt print_eight_bit

# ========== 補完・色 ==========
# 色機能の有効化
autoload -Uz colors
colors

# 補完キャッシュの有効化と保存先指定
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# 補完メニュー表示の改善
zstyle ':completion:*' menu select               # 選択可能にする
zstyle ':completion:*' sort false                # 自然な順番で表示
zstyle ':completion:*' verbose yes               # 補完に説明表示
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# 補完初期化（compinit）はautoloadで読み込み後実行
autoload -U compinit
compinit

# 候補が2つ以上のときにメニュー表示
zstyle ':completion:*:default' menu select=2

# ========== 履歴検索強化 ==========
# カーソル位置を末尾に移動させて履歴を検索（上下キー）
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ========== 入力モード ==========
# viモード有効化（Escでノーマルモードに切り替え）
# bindkey -v

# ========== 補完パス追加 ==========
# Homebrew 経由で追加された zsh 補完を有効にする
fpath=("/opt/homebrew/share/zsh-completions" $fpath)

# zsh プラグイン（補完補助/構文ハイライト）
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# mise（バージョンマネージャ）の有効化
eval "$(mise activate zsh)"

# ========== FZF 補完 ==========
# fzf（インタラクティブ補完）設定読み込み（bash用でもzsh互換）
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ========== ghq補完 ==========
# ghqで管理されたリポジトリをfzfで選択してcd
function ghq-fzf() {
	local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
	if [ -n "$src" ]; then
		BUFFER="cd $(ghq root)/$src"
		zle accept-line
	fi
	zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# yazi（ターミナルファイラ）でディレクトリ選択後にcd
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ghq でリポジトリ選択し `cd`
cdrepo() {
	local repodir=$(ghq list | fzf -1 +m) && cd $(ghq root)/$repodir
}

# ghq でリポジトリ選択し VS Code を開く
coderepo() {
	local repodir=$(ghq list | fzf -1 +m) &&
	echo Open VSCode WorkSpace! : $(ghq root)/$repodir
	if [ -n "$repodir" ]; then
		code $(ghq root)/$repodir
	fi
}

# ghq でリポジトリ選択し Cursor（エディタ）を開く
csrepo() {
	local repodir=$(ghq list | fzf -1 +m) &&
	echo Open Cursor WorkSpace! : $(ghq root)/$repodir
	if [ -n "$repodir" ]; then
		cursor $(ghq root)/$repodir
	fi
}

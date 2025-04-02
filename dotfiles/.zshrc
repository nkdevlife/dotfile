
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

# =============================
# zsh config
# =============================
# 環境変数を補完する
setopt AUTO_PARAM_KEYS
# 履歴ファイルの保存先
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups


# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(mise activate zsh)"

# 補完やキーバインドを設定するシェルスクリプトが標準出力に表示される
source <(fzf --zsh)

# ghq ^gでプロジェクト移動
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

# yでyazi起動 qで終了 & 移動
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ghq cd
cdrepo() {
	local repodir=$(ghq list | fzf -1 +m) && cd $(ghq root)/$repodir
}

# 選択したリポジトリをvscodeで開く
coderepo() {
	local repodir=$(ghq list | fzf -1 +m) &&
	echo Open VSCode WorkSpace! : $(ghq root)/$repodir
	if [ -n "$repodir" ]; then
		code $(ghq root)/$repodir
	fi
}

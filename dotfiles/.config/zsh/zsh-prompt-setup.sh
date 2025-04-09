
# git-promptの読み込み
source "$HOME/.config/zsh/git-prompt.sh"

# git-completionの読み込み
fpath=("$HOME/.config/zsh/" $fpath)
zstyle ':completion:*:*:git:*' script "$HOME/.config/zsh/git-completion.bash"
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定(好きなようにカスタマイズ可)
setopt PROMPT_SUBST ; PS1='%F{green}%n%f %F{cyan}%~%f %F{magenta}$(__git_ps1 "[%s]")%f
\$ '

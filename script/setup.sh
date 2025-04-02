#!/usr/bin/env bash

# ================================================================================
# 【For Mac】MacOS.sh : Setup MacOS
# ================================================================================

if [ "$(uname)" != "Darwin" ]; then
    echo 'Not macOS'
    exit 1
fi

echo 'Setting up macOS...'

# =============================
# システム設定
# =============================

# ブート時のサウンドを無効化する
sudo nvram StartupMute=%01
# 時計アイコンクリック時に OS やホスト名 IP を表示する
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# dark mode
defaults write -g NSRequiresAquaSystemAppearance -bool true

# =============================
# ユーザーインターフェース設定
# =============================
# ファイルを開くときのアニメーションを無効化
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# ツールチップ表示の遅延をなくす
defaults write -g NSInitialToolTipDelay -int 0
# ウィンドウリサイズ速度を高速化
defaults write -g NSWindowResizeTime -float 0.1
# スクロールバーを常時表示
defaults write -g AppleShowScrollBars -string "Always"

# =============================
# Finder 設定
# =============================
# 非表示ファイルやフォルダを表示
defaults write -g com.apple.finder AppleShowAllFiles -bool true
# 全ての拡張子のファイルを表示
defaults write -g AppleShowAllExtensions -bool true
# Finder のタイトルバーにフルパスを表示
defaults write -g com.apple.finder _FXShowPosixPathInTitle -bool true
# ディレクトリをリストの先頭に表示
defaults write -g com.apple.finder _FXSortFoldersFirst -bool true
# Finder のアニメーション効果を全て無効化
defaults write -g com.apple.finder DisableAllAnimations -bool true
# Finder にパスバー、ステータスバー、タブバーを表示
defaults write -g com.apple.finder ShowPathbar -bool true
defaults write -g com.apple.finder ShowStatusBar -bool true
defaults write -g com.apple.finder ShowTabView -bool true
# Finder を終了可能にする
defaults write -g com.apple.Finder QuitMenuItem -bool true
# ゴミ箱を空にするときの警告無効化
defaults write -g com.apple.finder WarnOnEmptyTrash -bool false

# =============================
# Dock 設定
# =============================
# Dock を自動的に隠す
defaults write -g com.apple.dock autohide -bool true
# Dock の表示遅延をなくす
defaults write -g com.apple.dock autohide-delay -float 0
# Dock のアイコンサイズを変更
defaults write -g com.apple.dock tilesize -int 40
# Dock からすべてのアプリを削除
defaults write -g com.apple.dock persistent-apps -array
# Dock のアイコンホバー時に拡大設定
defaults write com.apple.dock magnification -bool true
# Dock のアイコンホバー時に拡大サイズ
defaults write com.apple.dock largesize -int 80

# =============================
# Screenshot
# =============================
# 画像の影を無効化
defaults write com.apple.screencapture "disable-shadow" -bool "true"
# スクリーンショットの形式をPNGに
defaults write com.apple.screencapture type -string "png"
# 保存場所
if [[ ! -d "$HOME/Pictures/Screenshots" ]]; then
    mkdir -p "$HOME/Pictures/Screenshots"
fi
defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots"


# =============================
# Safari 設定
# =============================
# ダウンロード後の自動実行を無効化
defaults write -g com.apple.Safari AutoOpenSafeDownloads -bool false
# Safari の開発・デバッグメニューを有効化
defaults write -g com.apple.Safari IncludeDevelopMenu -bool true
# Safari の検索クエリを Apple へ送信しない
defaults write -g com.apple.Safari UniversalSearchEnabled -bool false
# アドレスバーに完全な URL を表示
defaults write -g com.apple.Safari ShowFullURLInSmartSearchField -bool true

# =============================
# キーボード
# =============================
# キーリピート速度を高速化
defaults write -g KeyRepeat -int 3
# キーリピート開始までの遅延を短縮
defaults write -g InitialKeyRepeat -int 15
# キーホールドで連続入力
defaults write -g ApplePressAndHoldEnabled -bool false
# フルキーボードアクセスを有効化
defaults write -g AppleKeyboardUIMode -int 3
# 自動大文字変換を無効化
defaults write -g NSAutomaticCapitalizationEnabled -bool false
# 自動スペル修正を無効化
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false
# スペルの訂正を無効化
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# ダブルスペースでピリオド変換する機能を無効化する
defaults write NSAutomaticPeriodSubstitutionEnabled -bool false
# 入力時のダッシュへの自動変換を無効化する
defaults write NSAutomaticDashSubstitutionEnabled -bool false
# 入力時のクォート（引用符）の自動変換を無効化する
defaults write NSAutomaticQuoteSubstitutionEnabled -bool false

# =============================
# トラックパッド & マウス
# =============================
# トラックパッド設定
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# タップでクリックを有効化
defaults write -g com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# マウスカーソルのスピードを最速化
defaults write -g com.apple.mouse.scaling -int 3
# スクロール方向をWindowsに合わせる
defaults write -g com.apple.swipescrolldirection -bool "false"
# ダブルクリックの反応速度（間隔）を設定する
defaults write com.apple.mouse.doubleClickThreshold -float 0.5
# マウスホイールによるスクロール速度を設定する
defaults write com.apple.scrollwheel.scaling -int 4

# =============================
# Feedback
# =============================
## フィードバックを送信しないdefaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"
## クラッシュレポート無効化
defaults write com.apple.CrashReporter DialogType -string "none"

# =============================
# ネットワーク設定
# =============================
# Google のパブリック DNS を使用
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
## ファイアウォールon
sudo defaults write /Library/Preferences/com.Apple.alf globalstate -int 1

# =============================
# Finder & Dock 再起動
# =============================
killall Finder
killall Dock
killall SystemUIServer

echo 'macOS setup completed.'

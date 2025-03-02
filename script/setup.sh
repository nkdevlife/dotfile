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

# =============================
# ユーザーインターフェース設定
# =============================
# ファイルを開くときのアニメーションを無効化
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# ツールチップ表示の遅延をなくす
defaults write -g NSInitialToolTipDelay -integer 0
# ウィンドウリサイズ速度を高速化
defaults write -g NSWindowResizeTime -float 0.1
# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# スクロールバーを常時表示
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# =============================
# Finder 設定
# =============================
# 非表示ファイルやフォルダを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder のタイトルバーにフルパスを表示
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# ディレクトリをリストの先頭に表示
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Finder のアニメーション効果を全て無効化
defaults write com.apple.finder DisableAllAnimations -bool true
# Finder にパスバー、ステータスバー、タブバーを表示
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
# Finder を終了可能にする
defaults write com.apple.Finder QuitMenuItem -bool true

# =============================
# Dock 設定
# =============================
# Dock を自動的に隠す
defaults write com.apple.dock autohide -bool true
# Dock の表示遅延をなくす
defaults write com.apple.dock autohide-delay -float 0
# Dock のアイコンサイズを変更
defaults write com.apple.dock tilesize -int 40
# Dock からすべてのアプリを削除
defaults write com.apple.dock persistent-apps -array

# =============================
# Safari 設定
# =============================
# ダウンロード後の自動実行を無効化
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Safari の開発・デバッグメニューを有効化
defaults write com.apple.Safari IncludeDevelopMenu -bool true
# Safari の検索クエリを Apple へ送信しない
defaults write com.apple.Safari UniversalSearchEnabled -bool false
# アドレスバーに完全な URL を表示
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# =============================
# キーボード & マウス
# =============================
# キーボード設定
# キーリピート速度を高速化
defaults write NSGlobalDomain KeyRepeat -int 2
# キーリピート開始までの遅延を短縮
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# フルキーボードアクセスを有効化
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# トラックパッド設定
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# タップでクリックを有効化
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# =============================
# システム最適化
# =============================
# 自動大文字変換を無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# 自動スペル修正を無効化
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# スクリーンショットの形式をPNGに
defaults write com.apple.screencapture type -string "png"
# スペルの訂正を無効化
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# =============================
# ネットワーク設定
# =============================
# Google のパブリック DNS を使用
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4

# =============================
# Finder & Dock 再起動
# =============================
killall Finder
killall Dock
killall SystemUIServer

echo 'macOS setup completed.'

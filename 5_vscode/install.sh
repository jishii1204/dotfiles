#!/usr/bin/env bash

# codeコマンドがなければVSCodeをインストール
if ! (type code > /dev/null 2>&1); then
  if ! (type brew > /dev/null 2>&1); then
    sh homebrew/install.sh
  fi
  brew install --cask visual-studio-code
fi

# settings.jsonの設置
ln -sfv "$PWD"/5_vscode/settings.json ~/Library/Application\ Support/Code/User/

# プラグインのインストール
pkglist=(
  alefragnani.project-manager	# Project Manager
  editorconfig.editorconfig # EditorConfig for VS Code
  gruntfuggly.todo-tree # Todo Tree
  ms-azuretools.vscode-docker # Docker
  ms-ceintl.vscode-language-pack-ja # Japanese Language Pack for Visual Studio Code
  ms-vscode-remote.remote-ssh-edit # Remote - SSH: Editing Configuration Files
  vscode-icons-team.vscode-icons # vscode-icons
  wakatime.vscode-wakatime # WakaTime
)

for i in "${pkglist[@]}"; do
  code --install-extension "$i"
done

echo "👍 VSCode setting is done!"

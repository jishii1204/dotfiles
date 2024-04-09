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
  # for Common
  alefragnani.project-manager	# Project Manager
  editorconfig.editorconfig # EditorConfig for VS Code
  esbenp.prettier-vscode # Prettier - Code formatter
  gruntfuggly.todo-tree # Todo Tree
  mechatroner.rainbow-csv # Rainbow CSV
	moshfeu.compare-folders # Compare Folders
  ms-azuretools.vscode-docker # Docker
  ms-ceintl.vscode-language-pack-ja # Japanese Language Pack for Visual Studio Code
  ms-vscode.makefile-tools # Makefile Tools
  ms-vscode-remote.remote-containers # Dev Containers
  ms-vscode-remote.remote-ssh-edit # Remote - SSH: Editing Configuration Files
  oderwat.indent-rainbow # indent-rainbow
	svipas.prettier-plus # Prettier+
  vscode-icons-team.vscode-icons # vscode-icons
  # for Golang
	golang.Go # Go
  windmilleng.vscode-go-autotest # Go Autotest
  766b.go-outliner # Go Outliner
  # for Ruby on Rails
  karunamurti.haml # Better Haml
	Shopify.ruby-lsp # Ruby LSP
)

for i in "${pkglist[@]}"; do
  code --install-extension "$i"
done

echo "👍 VSCode setting is done!"

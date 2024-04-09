#!/bin/sh

# link
basename -a "$PWD"/4_dotfiles/.??* | xargs -I{} ln -sfv "$PWD"/4_dotfiles/{} ~/{}

# Zinit (Zsh plugin manager)
sh -c "$(curl -fsSL https://git.io/zinit-install)"
if ! grep -q -v "4_dotfiles/.plugins.zsh" ~/.zshrc; then
    echo ". $PWD/4_dotfiles/.plugins.zsh" >> ~/.zshrc
fi

# Delete .DS_Store
if ! grep -q -v "alias dsstore=" ~/.zshrc; then
    echo "alias dsstore=\"find . -name '*.DS_Store' -type f -ls -delete\"" >> ~/.zshrc
fi

echo "👍 dotfiles link is done!"

#!/bin/sh

# asdfコマンドがなければasdfをインストール
if ! (type asdf > /dev/null 2>&1); then
  if ! (type brew > /dev/null 2>&1); then
    sh 1_homebrew/install.sh
  fi
  brew install coreutils curl git
  brew install asdf
fi

# add to shell
echo ". $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
. ~/.zshrc

# Default Packages
basename -a "$PWD"/2_asdf/.default-* | xargs -I{} ln -sfv "$PWD"/2_asdf/{} ~/{}

# === asdf-nodejs ===
# Requirements
brew install coreutils gpg gawk
# Install plugin
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Install Node.js
asdf install nodejs latest
asdf global nodejs "$(asdf list nodejs | tail -1 | sed -e 's/ //g')"

# === asdf-python ===
# Install plugin
asdf plugin-add python https://github.com/danhper/asdf-python
# Install Python
asdf install python latest
asdf global python "$(asdf list python | tail -1 | sed -e 's/ //g')"

# === asdf-ruby ===
# Requirements(optional, but recommended)
brew install openssl@1.1 readline libyaml
# Install plugin
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
# Install Ruby
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)" LDFLAGS="-L/opt/homebrew/opt/readline/lib" CPPFLAGS="-I/opt/homebrew/opt/readline/include" PKG_CONFIG_PATH="/opt/homebrew/opt/readline/lib/pkgconfig" optflags="-Wno-error=implicit-function-declaration" LDFLAGS="-L/opt/homebrew/opt/libffi/lib" CPPFLAGS="-I/opt/homebrew/opt/libffi/include" PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig" RUBY_CFLAGS="-w" asdf install ruby 2.7.3
asdf global ruby "$(asdf list ruby | tail -1 | sed -e 's/ //g')"

echo "👍 asdf install is done!"

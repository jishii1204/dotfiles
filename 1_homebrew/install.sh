#!/bin/sh

# Install xcode
# Check if command line tools are installed
if ! xcode-select --print-path &> /dev/null; then
  # Install command line tools
  echo "Command line tools not found. Installing..."
  xcode-select --install
else
  echo "Command line tools are already installed."
fi

# Install brew
# Check if brew are installed
if ! (type brew > /dev/null 2>&1); then
  # Install brew
  echo "brew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ "$(uname -m)" = "arm64" ] ; then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/${USER}/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source /Users/${USER}/.zprofile
  fi
else
  echo "brew is already installed."
fi

# Install Rosetta 2 for Apple Silicon
# Check if Rosetta 2 is installed
if [[ $(sysctl -n machdep.cpu.brand_string) != *"Apple M"* ]]; then
  echo "Rosetta 2 is already installed."
else
  # Install Rosetta 2
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
  if [ $? -ne 0 ]; then
    echo "Error: Failed to install Rosetta 2."
  fi
fi

# Brewfileを実行
cd "$PWD"/1_homebrew || exit
brew bundle
cd - || exit


#s_path=""
#s_manpath=""

# coreutils
s_path="/opt/homebrew/opt/coreutils/libexec/gnubin:${s_path}"
s_manpath="/opt/homebrew/opt/coreutils/libexec/gnuman:${s_manpath}"

# curl
s_path="/opt/homebrew/opt/curl/bin:${s_path}"

#shellcheck disable=SC2016
if ! grep -q -v "export PATH=" ~/.zshrc; then
    echo "export PATH=\"${s_path}"'$PATH"' >> ~/.zshrc
fi
#shellcheck disable=SC2016
if ! grep -q -v "export MANPATH=" ~/.zshrc; then
  echo "export MANPATH=\"${s_manpath}"'$MANPATH"' >> ~/.zshrc
fi
#shellcheck disable=SC1090
. ~/.zshrc

echo "👍 Homebrew setting is done!"

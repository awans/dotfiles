echo "Setting up Homebrew"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

echo "Installing cask..."

CASKS=(
    google-chrome
    dropbox-passwords
    dropbox
    iterm2
    slack
    divvy
    homebrew/cask-drivers/sonos
    sublime-text
    bartender
    discord
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

exit 0

PACKAGES=(
    asdf
    git
    graphviz
    github/gh/gh
    npm
    the_silver_searcher
    tree
    vim
    wget
    fzf
    golang
    nim
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Configuring OSX..."

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Configuring asdf..."

echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc


echo "All done!"

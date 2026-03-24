# dotfiles

Sketchybar + AeroSpace config for macOS.

## Setup

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install sketchybar
brew install --cask nikitabobko/tap/aerospace
brew install --cask font-fira-code-nerd-font

# Clone and symlink
git clone https://github.com/thomasporter522/dotfiles.git ~/Code/dotfiles
ln -s ~/Code/dotfiles/sketchybar ~/.config/sketchybar
ln -s ~/Code/dotfiles/aerospace ~/.config/aerospace

# Start sketchybar
brew services start sketchybar
```

Launch AeroSpace from Applications. Grant accessibility permissions when prompted.

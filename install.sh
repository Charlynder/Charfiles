<<<<<<< HEAD
#!/usr/bin/env bash

# --- Charlyder macOS install script ---
#
# date created: 08.29.2025

# --- gum ---
# ensure gum is installed (silent)
install_gum() {
    if ! command -v gum &> /dev/null; then
        tmpdir=$(mktemp -d)
        curl -sSL "https://github.com/charmbracelet/gum/releases/latest/download/gum_$(uname -s)_$(uname -m).tar.gz" \
        | tar -xz -C "$tmpdir"
        sudo mv "$tmpdir/gum" /usr/local/bin/gum >/dev/null 2>&1
        rm -rf "$tmpdir"
    fi
}

# install gum if missing
install_gum

# --- package manager ---
# install Homebrew on to the system
if command -v brew &> /dev/null; then
    echo "✅ Homebrew is already installed."
else
    echo "🚀 Homebrew not found. Installing..."
    
    # Download the installer script first
    gum spin --spinner dot --title "Downloading Homebrew installer..." -- \
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/homebrew_install.sh
    
    # Run the installer (needs to be interactive)
    echo "Running Homebrew installer..."
    /bin/bash /tmp/homebrew_install.sh
    
    # Clean up
    rm -f /tmp/homebrew_install.sh

    # Add Homebrew to PATH if necessary
    if [[ -d "/opt/homebrew/bin" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/bin" ]]; then
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "✅ Homebrew installation complete."
fi

# --- packages:Brewfile ---
# install Homebrew files
brew bundle

# --- configuration ---
# make syslinks for config
if [ ! -d ~/.config ]; then
    gum spin --spinner dot --title "Creating Config folder..." -- mkdir ~/.config
    sleep 1
else
    echo "✅ Config directory already exists!"
fi
=======
#!/bin/bash
# Dotfiles installation script using GNU Stow
# Author: Charlynder

set -e

DOTFILES_DIR="$HOME/development/dotfiles"
TARGET_DIR="$HOME"

echo "🏠 Installing dotfiles using GNU Stow..."

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow is not installed. Please install it first:"
    echo "   brew install stow"
    exit 1
fi

# Change to dotfiles directory
cd "$DOTFILES_DIR"

# List of packages to stow
PACKAGES=(
    "zsh"
    "git" 
    "nvim"
    "tmux"
    "ghostty"
    "fastfetch"
    "oh-my-zsh"
)

echo "📦 Stowing packages:"

for package in "${PACKAGES[@]}"; do
    if [ -d "$package" ]; then
        echo "  ✓ Stowing $package"
        stow --target="$TARGET_DIR" "$package"
    else
        echo "  ⚠️  Package $package not found, skipping"
    fi
done

echo ""
echo "✅ Dotfiles installation complete!"
echo ""
echo "📝 Next steps:"
echo "   • Restart your terminal or run 'exec zsh'"
echo "   • Make sure your PATH includes ~/development/dotfiles/bin if you have custom scripts"
echo ""
>>>>>>> 2dc083c (feat: ghostty theme update for Tahoe)

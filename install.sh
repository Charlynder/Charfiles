#!usr/bin/env bash

# Charfiles installer script
# date created: 09.01.2025

# --- variables ---
CFILE=".charfile"

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

# --- title ---
echo "--- 🐦‍🔥 Charfiles installer ---"

# --- Installed Checker ---
if gum spin --spinner dot --title "Checking if Charfiles is installed..." -- bash -c "
    sleep 2
    if [ -f \"$CFILE\" ]; then
        echo 'installed'
        exit 0
    else
        echo 'not_installed'
        exit 1
    fi
"; then
    sleep 1
    echo "✅ CharFiles is already installed!"
    exit 0
else
    echo "❌ CharFiles not found. Starting installation..."
fi

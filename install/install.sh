#!/usr/bin/env bash

# Charfiles installer script
# date created: 09.01.2025

# --- variables ---
CFILE=".charfile"

# --- git repo --
# make temp directory 

# clone the git repo without showing the output
git clone https://github.com/Charlynder/Charfiles.git > /dev/null 2>&1

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
echo "--- ♋︎Charfiles installer ---"

# --- Installed Checker ---
if gum spin --spinner dot --title "Checking if Charfiles has already been installed..." -- bash -c "
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

# --- user info ---
# prompt the user if they want to setup git username and email
if gum confirm "Do you want to setup git username and email into \'.gitconfig\'";then
	# prompt the user for git username and email
	echo -n "Git unsername"
	GITUSERNAME=$(gum input --placeholder "Enter git username")
	echo -n "Git email"
	GITEMAIL=$(gum input --placeholder "Enter git email")

	git config --global user.name "$GITUSERNAME"
	git config --global user.email "$GITEMAIL"

	echo "✅ Git has been configured!"
else
	gum spin --spinner dot --title "Skipping Git credential setup..." -- bash -c "
	sleep 2
	echo ' '
	"
	echo '❌ Git setup skipped 😭'
fi

#!/usr/bin/env bash

set -e

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Please install it first."
    echo "  macOS: brew install fzf"
    echo "  Linux: sudo apt install fzf (or use your package manager)"
    exit 1
fi

# Check if AWS config file exists
AWS_CONFIG="${AWS_CONFIG_FILE:-$HOME/.aws/config}"
if [[ ! -f "$AWS_CONFIG" ]]; then
    echo "Error: AWS config file not found at $AWS_CONFIG"
    exit 1
fi

# Get current profile
CURRENT_PROFILE="${AWS_PROFILE:-default}"

# Extract all profile names from the config file
# Matches lines like [profile name] or [default]
PROFILES=$(grep -E '^\[profile .+\]|^\[default\]' "$AWS_CONFIG" | \
    sed -E 's/^\[profile (.+)\]/\1/; s/^\[(default)\]/\1/' | \
    sort -u)

if [[ -z "$PROFILES" ]]; then
    echo "No profiles found in $AWS_CONFIG"
    exit 1
fi

# Use fzf to select a profile
# Highlight the current profile
SELECTED=$(echo "$PROFILES" | \
    fzf --height=40% \
        --border \
        --prompt="AWS Profile> " \
        --preview="grep -A 10 '^\[profile {}\]\\|^\[{}\]' $AWS_CONFIG" \
        --preview-window=right:60%:wrap \
        --header="Current: $CURRENT_PROFILE")

if [[ -z "$SELECTED" ]]; then
    echo "No profile selected"
    exit 0
fi

# Output the export command
echo "export AWS_PROFILE=$SELECTED"

#!/usr/bin/env bash

set -e

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Please install it first."
    echo "  macOS: brew install fzf"
    echo "  Linux: sudo apt install fzf (or use your package manager)"
    exit 1
fi

# Get current region
CURRENT_REGION="${AWS_REGION:-${AWS_DEFAULT_REGION:-}}"

REGIONS="us-east-1
us-west-2
"

# Use fzf to select a region
SELECTED=$(echo "$REGIONS" | \
    fzf --height=40% \
        --border \
        --prompt="AWS Region> " \
        --header="Current: ${CURRENT_REGION:-none}")

if [[ -z "$SELECTED" ]]; then
    echo "No region selected"
    exit 0
fi

# Output the export command
echo "export AWS_REGION=$SELECTED"
echo "export AWS_DEFAULT_REGION=$SELECTED"

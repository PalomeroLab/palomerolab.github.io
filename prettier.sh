#!/bin/bash
# Format files with Prettier

LINELEN=124

# Check if Prettier is installed
if ! command -v prettier &> /dev/null; then
	echo "Prettier is not installed. Please install it first."
	exit 1
fi

# Format Hugo layout with custom line length
prettier --write --print-width "$LINELEN" ./layouts/index.html

# Format all other files with default settings
prettier --write --ignore-unknown README.md hugo.toml .github/workflows/*.yml static/people.json static/assets/**

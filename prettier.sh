#!/bin/bash
# Format files with Prettier

LINELEN=124

# Check if Prettier is installed
if ! command -v prettier &> /dev/null; then
	echo "Prettier is not installed. Please install it first."
	exit 1
fi

# Format index.html with custom line length
prettier --write --print-width "$LINELEN" ./index.html

# Format all other files with default settings
prettier --write --ignore-unknown README.md people.json assets/**

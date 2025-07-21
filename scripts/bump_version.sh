#!/bin/bash

# Check if version type is provided
if [ -z "$1" ]; then
    echo "Please provide version type: major, minor, or patch"
    exit 1
fi

# Read current version from pubspec.yaml
CURRENT_VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //')
CURRENT_VERSION=${CURRENT_VERSION%+*}

# Split version into components
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

# Increment version based on type
case "$1" in
    "major")
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    "minor")
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    "patch")
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "Invalid version type. Use: major, minor, or patch"
        exit 1
        ;;
esac

# Create new version string
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Update version in pubspec.yaml
sed -i.bak "s/version: .*/version: $NEW_VERSION+$(($(date +%s) / 60))/" pubspec.yaml
rm pubspec.yaml.bak

echo "Version bumped from $CURRENT_VERSION to $NEW_VERSION" 
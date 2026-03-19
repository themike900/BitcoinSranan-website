#!/bin/bash

# Basis-Pfade
REPO="/opt/bitcoinsranan/repo"
CONTENT="$REPO/content"
ASSETS="$REPO/assets"
PUBLIC="/opt/bitcoinsranan/public"

TEMPLATE="$ASSETS/template.html"

# Public-Ordner leeren
rm -rf "$PUBLIC"/*
mkdir -p "$PUBLIC"

# Stylesheet kopieren
cp "$ASSETS/style.css" "$PUBLIC/style.css"

# Bilder kopieren
mkdir -p "$PUBLIC/images"
cp -r "$ASSETS/images/"* "$PUBLIC/images/"

# Liste aller Markdown-Dateien und Ziel-HTML-Dateien
FILES=(
    "index.md:index.html"
    "locals.md:locals.html"
    "internationals.md:internationals.html"
    "projects.md:projects.html"
    "resources.md:resources.html"
    "community-hub.md:community-hub.html"
    "blog.md:blog.html"
    "contact.md:contact.html"
    "strategy.md:startegy.html"
    "old-btcpay.md:old-btcpay.html"
)

# Pandoc Build
for entry in "${FILES[@]}"; do
    IFS=":" read -r md html <<< "$entry"
    pandoc "$CONTENT/$md" -o "$PUBLIC/$html" --template="$TEMPLATE"
done

echo "Build complete."

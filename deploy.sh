#!/bin/bash
# Deploy script - Build locally and push to gh-pages
# This bypasses GitHub Actions gem installation issues

set -e  # Exit on error

echo "🔨 Building Jekyll site locally (production)..."
JEKYLL_ENV=production bundle exec jekyll build

echo "📁 Preparing gh-pages branch..."

# Create a temporary directory for gh-pages
TMP_DIR=$(mktemp -d)
echo "Using temp directory: $TMP_DIR"

# Copy built site to temp directory
cp -r _site/* $TMP_DIR/

# Initialize git in temp directory if needed
cd $TMP_DIR
git init
git remote add origin $(cd - > /dev/null && git remote get-url origin)

# Create gh-pages branch and commit
git checkout -b gh-pages
git add -A
git commit -m "Deploy site - $(date '+%Y-%m-%d %H:%M:%S')"

echo "🚀 Pushing to gh-pages branch..."
git push origin gh-pages --force

echo "✅ Deployment complete!"
echo "🌐 Your site will be available at: https://faustiandreams.github.io"
echo "⏱️  GitHub Pages will update in 1-2 minutes"

# Cleanup
cd - > /dev/null
rm -rf $TMP_DIR

echo "🧹 Cleaned up temporary files"

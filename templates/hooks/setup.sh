#!/bin/bash
# Git hooks setup script
# This script sets up Git hooks for the repository

set -e

HOOK_DIRECTORY=$(git rev-parse --git-dir)/hooks
SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🪝 Setting up Git hooks...${NC}"

# Create hooks directory if it doesn't exist
mkdir -p "$HOOK_DIRECTORY"

# Install pre-commit hook
echo -e "${YELLOW}Installing pre-commit hook...${NC}"
cp "$SCRIPT_DIRECTORY/pre-commit" "$HOOK_DIRECTORY/pre-commit"
chmod +x "$HOOK_DIRECTORY/pre-commit"

# Install commit-msg hook
echo -e "${YELLOW}Installing commit-msg hook...${NC}"
cp "$SCRIPT_DIRECTORY/commit-msg" "$HOOK_DIRECTORY/commit-msg"
chmod +x "$HOOK_DIRECTORY/commit-msg"

# Install pre-push hook if it exists
if [ -f "$SCRIPT_DIRECTORY/pre-push" ]; then
    echo -e "${YELLOW}Installing pre-push hook...${NC}"
    cp "$SCRIPT_DIRECTORY/pre-push" "$HOOK_DIRECTORY/pre-push"
    chmod +x "$HOOK_DIRECTORY/pre-push"
fi

# Check for Husky
if [ -f "package.json" ] && grep -q "husky" package.json; then
    echo -e "${BLUE}📦 Husky detected in package.json${NC}"
    echo -e "${YELLOW}⚠️  Note: These Git hooks may be overridden by Husky.${NC}"
    echo -e "To integrate with Husky, consider adding these scripts to your Husky configuration."
fi

echo -e "${GREEN}✅ Git hooks installed successfully!${NC}"
echo -e "${BLUE}Installed hooks:${NC}"
find "$HOOK_DIRECTORY" -type f -executable -not -name "*.sample" | while read hook; do
    echo -e "  - $(basename "$hook")"
done

echo -e "${YELLOW}Note: You can bypass hooks using --no-verify flag (e.g., git commit --no-verify)${NC}"
echo -e "${YELLOW}However, this is not recommended for team workflows.${NC}"

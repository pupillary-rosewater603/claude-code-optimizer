#!/bin/bash
# Claude Code Optimizer - Setup Script
# By Huzefa Nalkheda Wala | github.com/huzaifa525
# Usage: bash /path/to/claude-code-optimizer/scripts/setup.sh
#
# Run this in your project directory to set up Claude Code optimization

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/../templates"
PROJECT_DIR="$(pwd)"

echo "╔══════════════════════════════════════╗"
echo "║   Claude Code Optimizer Setup        ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "Project: $PROJECT_DIR"
echo ""

# Check if already set up
if [ -f "$PROJECT_DIR/.claude/rules/frontend.md" ]; then
    echo "WARNING: .claude/rules/ already exists in this project."
    read -p "Overwrite? (y/N): " OVERWRITE
    if [ "$OVERWRITE" != "y" ] && [ "$OVERWRITE" != "Y" ]; then
        echo "Aborted."
        exit 0
    fi
fi

# Create directories
echo "Creating directory structure..."
mkdir -p "$PROJECT_DIR/.claude/rules"
mkdir -p "$PROJECT_DIR/.claude/skills/explore-area"
mkdir -p "$PROJECT_DIR/.claude/skills/gen-context"
mkdir -p "$PROJECT_DIR/.claude/skills/smart-edit"
mkdir -p "$PROJECT_DIR/.claude/skills/token-check"
mkdir -p "$PROJECT_DIR/.claude/hooks"

# Copy templates
echo "Copying templates..."

# CLAUDE.md — only if it doesn't exist
if [ ! -f "$PROJECT_DIR/CLAUDE.md" ] && [ ! -f "$PROJECT_DIR/.claude/CLAUDE.md" ]; then
    cp "$TEMPLATE_DIR/CLAUDE.md" "$PROJECT_DIR/CLAUDE.md"
    echo "  + CLAUDE.md (edit this with your project details)"
else
    echo "  ~ CLAUDE.md already exists, skipping"
fi

# .claudeignore — only if it doesn't exist
if [ ! -f "$PROJECT_DIR/.claudeignore" ]; then
    cp "$TEMPLATE_DIR/.claudeignore" "$PROJECT_DIR/.claudeignore"
    echo "  + .claudeignore"
else
    echo "  ~ .claudeignore already exists, skipping"
fi

# Rules
cp "$TEMPLATE_DIR/.claude/rules/frontend.md" "$PROJECT_DIR/.claude/rules/"
cp "$TEMPLATE_DIR/.claude/rules/backend.md" "$PROJECT_DIR/.claude/rules/"
cp "$TEMPLATE_DIR/.claude/rules/database.md" "$PROJECT_DIR/.claude/rules/"
cp "$TEMPLATE_DIR/.claude/rules/testing.md" "$PROJECT_DIR/.claude/rules/"
echo "  + .claude/rules/ (4 rule files)"

# Skills
cp "$TEMPLATE_DIR/.claude/skills/explore-area/SKILL.md" "$PROJECT_DIR/.claude/skills/explore-area/"
cp "$TEMPLATE_DIR/.claude/skills/gen-context/SKILL.md" "$PROJECT_DIR/.claude/skills/gen-context/"
cp "$TEMPLATE_DIR/.claude/skills/smart-edit/SKILL.md" "$PROJECT_DIR/.claude/skills/smart-edit/"
cp "$TEMPLATE_DIR/.claude/skills/token-check/SKILL.md" "$PROJECT_DIR/.claude/skills/token-check/"
echo "  + .claude/skills/ (4 skills)"

# Hooks
cp "$TEMPLATE_DIR/.claude/hooks/generate-context.sh" "$PROJECT_DIR/.claude/hooks/"
cp "$TEMPLATE_DIR/.claude/hooks/protect-files.sh" "$PROJECT_DIR/.claude/hooks/"
cp "$TEMPLATE_DIR/.claude/hooks/filter-test-output.sh" "$PROJECT_DIR/.claude/hooks/"
chmod +x "$PROJECT_DIR/.claude/hooks/"*.sh
echo "  + .claude/hooks/ (3 hooks)"

# Settings — only if it doesn't exist
if [ ! -f "$PROJECT_DIR/.claude/settings.json" ]; then
    cp "$TEMPLATE_DIR/.claude/settings.json" "$PROJECT_DIR/.claude/settings.json"
    echo "  + .claude/settings.json"
else
    echo "  ~ .claude/settings.json already exists, skipping"
    echo "    Add hooks manually from templates/.claude/settings.json"
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md with your project-specific details"
echo "  2. Edit .claude/rules/*.md for your stack"
echo "  3. Remove rules that don't apply (e.g., frontend.md for a pure API)"
echo "  4. Test: run 'claude' and try '/explore-area src/'"
echo ""
echo "Files created:"
find "$PROJECT_DIR/.claude" -type f | sort | sed "s|$PROJECT_DIR/||" | sed 's/^/  /'
if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    echo "  CLAUDE.md"
fi
if [ -f "$PROJECT_DIR/.claudeignore" ]; then
    echo "  .claudeignore"
fi

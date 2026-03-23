#!/bin/bash
# protect-files.sh
# Blocks Claude from editing sensitive files
# Add to .claude/settings.json under hooks.PreToolUse with matcher "Edit|Write"
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer
#
# Hook receives JSON on stdin with tool_input.file_path
# Exit 0 = allow, Exit 2 = block (stderr = reason shown to Claude)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# Add patterns for files Claude should never edit
PROTECTED_PATTERNS=(
    ".env"
    ".env.local"
    ".env.production"
    "credentials.json"
    "*.pem"
    "*.key"
    "package-lock.json"
    "yarn.lock"
    "pnpm-lock.yaml"
    ".git/"
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
    case "$FILE_PATH" in
        *"$pattern"*)
            echo "BLOCKED: $FILE_PATH matches protected pattern '$pattern'. This file should not be modified by Claude." >&2
            exit 2
            ;;
    esac
done

# Allow the edit
exit 0

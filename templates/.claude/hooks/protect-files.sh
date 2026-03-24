#!/bin/bash
# protect-files.sh
# Blocks Claude from editing sensitive files
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer
#
# Exit 0 = allow, Exit 2 = block

INPUT=$(cat)

# Parse JSON with node (guaranteed to exist), fallback to jq
if command -v node &>/dev/null; then
    FILE_PATH=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{console.log(JSON.parse(d).tool_input.file_path||'')}catch(e){console.log('')}})")
elif command -v jq &>/dev/null; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
else
    exit 0
fi

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

BASENAME=$(basename "$FILE_PATH")
DIRNAME=$(dirname "$FILE_PATH")

# Check exact filenames
case "$BASENAME" in
    .env|.env.local|.env.production|.env.staging|.env.development)
        echo "BLOCKED: $FILE_PATH is an environment file." >&2
        exit 2 ;;
    credentials.json|service-account.json)
        echo "BLOCKED: $FILE_PATH is a credentials file." >&2
        exit 2 ;;
    package-lock.json|yarn.lock|pnpm-lock.yaml|Pipfile.lock|poetry.lock|Cargo.lock|composer.lock)
        echo "BLOCKED: $FILE_PATH is a lock file." >&2
        exit 2 ;;
esac

# Check file extensions
case "$BASENAME" in
    *.pem|*.key|*.p12|*.pfx)
        echo "BLOCKED: $FILE_PATH is a certificate/key file." >&2
        exit 2 ;;
esac

# Check directory paths
case "$FILE_PATH" in
    */.git/*)
        echo "BLOCKED: $FILE_PATH is inside .git directory." >&2
        exit 2 ;;
esac

exit 0

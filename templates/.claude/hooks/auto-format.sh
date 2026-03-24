#!/bin/bash
# auto-format.sh
# Auto-formats files after Claude edits them
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer

INPUT=$(cat)

# Parse JSON with node (guaranteed to exist), fallback to jq
if command -v node &>/dev/null; then
    FILE_PATH=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{console.log(JSON.parse(d).tool_input.file_path||'')}catch(e){console.log('')}})")
elif command -v jq &>/dev/null; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
else
    exit 0
fi

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

EXT="${FILE_PATH##*.}"

# Skip files where auto-formatting can be destructive
case "$EXT" in
    md|json|yaml|yml) exit 0 ;;
esac

case "$EXT" in
    js|jsx|ts|tsx|css|scss|html)
        if [ -f "node_modules/.bin/prettier" ]; then
            node_modules/.bin/prettier --write "$FILE_PATH" 2>/dev/null
        elif command -v prettier &>/dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
        fi
        ;;
    py)
        if command -v ruff &>/dev/null; then
            ruff format "$FILE_PATH" 2>/dev/null
        elif command -v black &>/dev/null; then
            black --quiet "$FILE_PATH" 2>/dev/null
        fi
        ;;
    go)
        if command -v gofmt &>/dev/null; then
            gofmt -w "$FILE_PATH" 2>/dev/null
        fi
        ;;
    rs)
        if command -v rustfmt &>/dev/null; then
            rustfmt "$FILE_PATH" 2>/dev/null
        fi
        ;;
esac

exit 0

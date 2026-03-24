#!/bin/bash
# filter-test-output.sh
# Filters verbose test/build/lint output to summary only
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer

INPUT=$(cat)

# Parse JSON with node (guaranteed to exist), fallback to jq
if command -v node &>/dev/null; then
    COMMAND=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{const j=JSON.parse(d);console.log(j.tool_input?.command||'')}catch(e){console.log('')}})")
    OUTPUT=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{const j=JSON.parse(d);console.log(j.tool_result?.stdout||j.tool_result||'')}catch(e){console.log('')}})")
elif command -v jq &>/dev/null; then
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)
    OUTPUT=$(echo "$INPUT" | jq -r '.tool_result.stdout // .tool_result // empty' 2>/dev/null)
else
    exit 0
fi

# Only filter test, build, and lint commands
case "$COMMAND" in
    *"npm test"*|*"jest"*|*"vitest"*|*"pytest"*|*"cargo test"*|*"go test"*)
        ;;
    *"npm run build"*|*"npm run lint"*|*"eslint"*|*"tsc"*|*"ruff check"*)
        ;;
    *)
        exit 0
        ;;
esac

LINE_COUNT=$(echo "$OUTPUT" | wc -l)
if [ "$LINE_COUNT" -lt 50 ]; then
    exit 0
fi

echo "Test output was $LINE_COUNT lines. Showing summary only:"
echo ""
echo "$OUTPUT" | grep -E "(FAIL|PASS|ERROR|✓|✗|Tests:|Suites:|failed|passed|error)" | head -30
echo ""
echo "(Full output truncated to save tokens.)"

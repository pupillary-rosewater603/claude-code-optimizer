#!/bin/bash
# block-dangerous.sh
# Blocks dangerous bash commands
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer
#
# Exit 0 = allow, Exit 2 = block

INPUT=$(cat)

# Parse JSON with node (guaranteed to exist), fallback to jq
if command -v node &>/dev/null; then
    CMD=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{console.log(JSON.parse(d).tool_input.command||'')}catch(e){console.log('')}})")
elif command -v jq &>/dev/null; then
    CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)
else
    exit 0
fi

if [ -z "$CMD" ]; then
    exit 0
fi

# Normalize: lowercase for matching
CMD_LOWER=$(echo "$CMD" | tr '[:upper:]' '[:lower:]')

# Literal dangerous patterns (exact substring match)
LITERAL_BLOCKS=(
    "rm -rf /"
    "rm -rf ~"
    "rm -rf \$home"
    "rm -rf ."
    "rm -fr /"
    "rm -r -f /"
    "git push --force origin main"
    "git push --force origin master"
    "git push -f origin main"
    "git push -f origin master"
    "git push origin main --force"
    "git push origin master --force"
    "git reset --hard"
    "git clean -fd"
    "git checkout -- ."
    "drop table"
    "drop database"
    "truncate table"
    "> /dev/sda"
    "mkfs."
    ":(){:|:&};:"
    "chmod -r 777 /"
)

for pattern in "${LITERAL_BLOCKS[@]}"; do
    if echo "$CMD_LOWER" | grep -qiF "$pattern"; then
        echo "BLOCKED: Command contains dangerous pattern '$pattern'. Ask the user to run it manually if needed." >&2
        exit 2
    fi
done

exit 0

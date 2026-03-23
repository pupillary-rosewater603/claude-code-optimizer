# Hooks Reference

> By [Huzefa Nalkheda Wala](https://huzefanalkhedawala.in/) | [GitHub](https://github.com/huzaifa525)

Hooks are shell commands that run automatically at specific lifecycle events in Claude Code. They can validate, block, automate, and inject context.

## Configuration

Add hooks to any settings file:

```json
// .claude/settings.json (project)
// ~/.claude/settings.json (user)
// .claude/settings.local.json (local, not committed)

{
  "hooks": {
    "EventName": [
      {
        "matcher": "pattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here"
          }
        ]
      }
    ]
  }
}
```

## Events

| Event | When | Matcher Values |
|-------|------|---------------|
| `SessionStart` | Session begins or resumes | `startup`, `resume`, `compact`, `clear` |
| `PreToolUse` | Before a tool executes | Tool name: `Bash`, `Edit`, `Write`, `Read`, `Grep`, `Glob` |
| `PostToolUse` | After a tool succeeds | Tool name |
| `PostToolUseFailure` | After a tool fails | Tool name |
| `Stop` | Claude finishes responding | (no matcher) |
| `Notification` | Claude needs user attention | `permission_prompt`, `idle_prompt` |
| `PreCompact` | Before context compaction | `manual`, `auto` |
| `PostCompact` | After compaction | `manual`, `auto` |

## Exit Codes

| Code | Meaning | Effect |
|------|---------|--------|
| `0` | Allow | Proceeds normally. Stdout injected as context. |
| `2` | Block | Stops the action. Stderr shown to Claude as reason. |
| Other | Error | Logged but doesn't block. |

## Input Format

Hooks receive JSON on stdin:

```json
// PreToolUse / PostToolUse
{
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "/path/to/file.ts",
    "old_string": "...",
    "new_string": "..."
  }
}

// SessionStart
{
  "type": "startup"  // or "resume", "compact", "clear"
}
```

## Recipes

### 1. Protect Sensitive Files

Block edits to .env, lock files, credentials:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/protect-files.sh"
          }
        ]
      }
    ]
  }
}
```

### 2. Auto-Format After Edits

Run Prettier/Black/rustfmt after Claude edits a file:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'INPUT=$(cat); FILE=$(echo \"$INPUT\" | jq -r \".tool_input.file_path\"); npx prettier --write \"$FILE\" 2>/dev/null || true'"
          }
        ]
      }
    ]
  }
}
```

### 3. Session Start Context

Inject git state when Claude starts:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/generate-context.sh"
          }
        ]
      }
    ]
  }
}
```

### 4. Prevent Dangerous Commands

Block `rm -rf`, `git push --force`, etc:

```bash
#!/bin/bash
# .claude/hooks/block-dangerous.sh
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

DANGEROUS=(
    "rm -rf /"
    "git push --force"
    "git reset --hard"
    "DROP TABLE"
    "DROP DATABASE"
    "git checkout ."
)

for pattern in "${DANGEROUS[@]}"; do
    if echo "$CMD" | grep -qi "$pattern"; then
        echo "BLOCKED: Command contains dangerous pattern '$pattern'" >&2
        exit 2
    fi
done

exit 0
```

### 5. Desktop Notification When Claude Finishes

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -Command \"[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Claude Code finished!', 'Claude Code')\""
          }
        ]
      }
    ]
  }
}
```

### 6. Log All Tool Usage

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'INPUT=$(cat); echo \"$(date +%H:%M:%S) $(echo $INPUT | jq -r .tool_name)\" >> .claude/tool-log.txt'"
          }
        ]
      }
    ]
  }
}
```

### 7. Require Tests After Code Changes

```bash
#!/bin/bash
# .claude/hooks/require-tests.sh
# Use with PostToolUse matcher "Edit|Write"
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Skip if editing a test file
case "$FILE" in
    *.test.*|*.spec.*|*__tests__*) exit 0 ;;
esac

# Skip non-source files
case "$FILE" in
    *.ts|*.tsx|*.js|*.jsx|*.py|*.go|*.rs)
        echo "Reminder: ensure tests exist for changes to $FILE"
        ;;
esac

exit 0
```

## Tips

- Test hooks with `echo '{"tool_name":"Bash","tool_input":{"command":"ls"}}' | bash .claude/hooks/your-hook.sh`
- Use `jq` for JSON parsing (comes pre-installed on most systems)
- Keep hooks fast (< 1 second) — they run synchronously
- Use `.claude/settings.local.json` for personal hooks you don't want committed
- View active hooks with `/hooks` command

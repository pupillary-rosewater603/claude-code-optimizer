# Understanding Token Usage in Claude Code

> By [Huzefa Nalkheda Wala](https://huzefanalkhedawala.in/) | [GitHub](https://github.com/huzaifa525)

## What Are Tokens?

Tokens are how AI models measure text. Roughly:
- 1 token ≈ 4 characters or ¾ of a word
- 100 lines of code ≈ 1,500-2,000 tokens
- A typical source file ≈ 3,000-10,000 tokens

## Where Tokens Go in Claude Code

### Every Single Turn Includes:

```
┌────────────────────────────────────────────┐
│ System Prompt          ~10,000-20,000 tokens│
│ (tool definitions, MCP schemas, rules)      │
├────────────────────────────────────────────┤
│ CLAUDE.md + rules      ~500-5,000 tokens   │
│ (loaded at session start)                   │
├────────────────────────────────────────────┤
│ Conversation History   grows every turn     │
│ (all messages + tool results)               │
├────────────────────────────────────────────┤
│ Current Message        varies               │
│ (your prompt + Claude's response)           │
└────────────────────────────────────────────┘
```

### Token Costs by Action

| Action | Input Tokens | Output Tokens | Notes |
|--------|-------------|---------------|-------|
| Read a file (500 lines) | ~3,000 | ~100 | File content enters context |
| Grep search | ~500-2,000 | ~100 | Results enter context |
| Glob search | ~200-1,000 | ~100 | File list enters context |
| Bash command | ~500-5,000 | ~100 | Full stdout enters context |
| Edit a file | ~200 | ~500 | Diff sent as output |
| Extended thinking | 0 | ~5,000-50,000 | Very expensive output tokens |
| Agent (subagent) | ~10,000+ | ~5,000+ | Separate context, billed separately |

### The Multiplier Effect

Here's why costs escalate fast:

```
Turn 1: System (15K) + CLAUDE.md (1K) + Your message (100) = 16K input
Turn 2: System (15K) + CLAUDE.md (1K) + History (5K) + Message (100) = 21K input
Turn 3: System (15K) + CLAUDE.md (1K) + History (15K) + Message (100) = 31K input
Turn 5: System (15K) + CLAUDE.md (1K) + History (40K) + Message (100) = 56K input
Turn 10: System (15K) + CLAUDE.md (1K) + History (100K) + Message (100) = 116K input
```

Every file read, every command output, every tool result — it all accumulates in history and gets re-sent every turn.

## Cost Per Model

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Thinking Output |
|-------|----------------------|----------------------|-----------------|
| Haiku | $0.80 | $4.00 | $4.00 |
| Sonnet | $3.00 | $15.00 | $15.00 |
| Opus | $15.00 | $75.00 | $75.00 |

### Cost Example: Simple Bug Fix

```
Sonnet, 8 turns:
  Input:  ~200K tokens × $3/1M  = $0.60
  Output: ~15K tokens × $15/1M  = $0.23
  Total: ~$0.83

Opus, 8 turns:
  Input:  ~200K tokens × $15/1M = $3.00
  Output: ~15K tokens × $75/1M  = $1.13
  Total: ~$4.13
```

Opus costs **5x more** for the same task.

## Red Flags (You're Wasting Tokens)

1. **Reading the same file 3+ times** in one session
2. **Broad Glob** followed by reading many results
3. **Running verbose commands** (full git log, npm ls, build with warnings)
4. **Long sessions** without `/compact` (history > 100K tokens)
5. **Opus for simple tasks** (formatting, simple edits, file creation)
6. **Large CLAUDE.md** loaded every turn (> 200 lines)
7. **Many MCP servers** adding tool schemas (> 30 tools)

## How to Monitor

- `/cost` — shows token usage and cost for current session
- `/context` — shows what's loaded and context window usage
- Status line — configure to show live token count

## Optimization Checklist

- [ ] CLAUDE.md under 200 lines
- [ ] .claudeignore excludes build artifacts and lock files
- [ ] Path-scoped rules in .claude/rules/
- [ ] Exploration skills use `context: fork`
- [ ] MAX_THINKING_TOKENS capped at 10000
- [ ] Default model is Sonnet (switch to Opus only when needed)
- [ ] Using `/compact` after exploration phases
- [ ] One task per session
- [ ] Specific prompts with file paths when possible

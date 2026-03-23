# Claude Code Optimizer

> **Created by [Huzefa Nalkheda Wala](https://huzefanalkhedawala.in/)** — AI Product Engineer | IIT Ropar | [GitHub](https://github.com/huzaifa525) | [LinkedIn](https://linkedin.com/in/huzefanalkheda) | [HuggingFace](https://huggingface.co/huzaifa525)

A complete toolkit to make Claude Code faster, cheaper, and smarter when working with your codebase.

## The Problem

Claude Code explores your codebase on every session — running Glob, Grep, and Read calls that burn tokens. Without guidance, it:

- Wastes 5-15 tool calls just to orient itself
- Re-reads the same files across sessions
- Misses project conventions and makes wrong assumptions
- Burns tokens on exploration instead of actual work

## The Solution

A layered context system that gives Claude a **compass instead of a GPS** — just enough structure to navigate efficiently, loaded only when relevant.

```
Token Usage Comparison:
┌─────────────────────────────────┬──────────────────┐
│ Without Optimizer               │ With Optimizer    │
├─────────────────────────────────┼──────────────────┤
│ ~20-40 tool calls per task      │ ~5-10 tool calls │
│ Full exploration every session  │ Targeted reads   │
│ No awareness of conventions     │ Follows patterns │
│ Re-discovers architecture       │ Knows the map    │
└─────────────────────────────────┴──────────────────┘
```

## What's Included

```
claude-code-optimizer/
├── templates/                    # Copy these into your project
│   ├── CLAUDE.md                 # Main project instructions template
│   ├── .claude/
│   │   ├── rules/                # Path-scoped rules (lazy-loaded)
│   │   │   ├── frontend.md
│   │   │   ├── backend.md
│   │   │   ├── database.md
│   │   │   └── testing.md
│   │   ├── skills/               # Custom skills
│   │   │   ├── explore-area/
│   │   │   │   └── SKILL.md
│   │   │   └── gen-context/
│   │   │       └── SKILL.md
│   │   └── hooks/                # Automation hooks
│   │       ├── generate-context.sh
│   │       └── protect-files.sh
│   └── .claudeignore             # Files Claude should skip
├── examples/                     # Real-world examples
│   ├── nextjs-app/
│   ├── express-api/
│   ├── python-fastapi/
│   └── monorepo/
├── scripts/
│   └── setup.sh                  # Auto-setup script
└── docs/
    ├── strategies.md             # All optimization strategies explained
    ├── token-guide.md            # Understanding token usage
    └── hooks-reference.md        # Hook recipes
```

## Quick Start

### Option 1: Auto Setup

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/claude-code-optimizer.git

# Run setup in your project directory
cd /path/to/your-project
bash /path/to/claude-code-optimizer/scripts/setup.sh
```

### Option 2: Manual Setup

1. Copy `templates/CLAUDE.md` to your project root
2. Copy `templates/.claude/` to your project
3. Copy `templates/.claudeignore` to your project root
4. Edit `CLAUDE.md` with your project-specific details
5. Edit rules in `.claude/rules/` for your stack

## How It Works

### Layer 0 — Always Loaded (~50 lines)

`CLAUDE.md` in your project root. Contains:
- Build/test commands
- Entry point map (5-6 key files)
- Request/data flow diagram
- Key decisions and gotchas

**Token cost: ~200 tokens every turn**

### Layer 1 — Path-Scoped Rules (loaded when relevant)

`.claude/rules/*.md` files with `paths:` frontmatter. Only loaded when Claude reads files matching those paths.

**Token cost: ~500 tokens, only when working in that area**

### Layer 2 — On-Demand Skills

`.claude/skills/` for exploration and context generation. Run in forked subagents so tokens don't pollute your main context.

**Token cost: 0 in main context (runs in subagent)**

### Layer 3 — Hooks (automatic)

Session start hooks that inject fresh git state. Pre-tool hooks that protect sensitive files.

**Token cost: ~100 tokens (hook output only)**

## Optimization Strategies

| Strategy | Token Savings | Effort |
|----------|--------------|--------|
| Lean CLAUDE.md with entry points | ~30% | Low |
| Path-scoped rules | ~20% | Medium |
| `.claudeignore` | ~15% | Low |
| Exploration skill (forked) | ~25% | Low |
| Session start hooks | ~10% | Medium |
| Code annotations (@claude tags) | ~15% | Medium |
| Cap thinking tokens | ~40% | Low |

## Configuration Tips

Add to your Claude Code settings:

```json
{
  "env": {
    "MAX_THINKING_TOKENS": "10000"
  }
}
```

## Contributing

1. Fork the repo
2. Add your stack-specific example in `examples/`
3. Submit a PR

## Author

**Huzefa Nalkheda Wala** — AI Product Engineer & Medical AI Researcher

- Website: [huzefanalkhedawala.in](https://huzefanalkhedawala.in/)
- GitHub: [@huzaifa525](https://github.com/huzaifa525)
- LinkedIn: [huzefanalkheda](https://linkedin.com/in/huzefanalkheda)
- HuggingFace: [huzaifa525](https://huggingface.co/huzaifa525)
- Medium: [huzefanalkheda](https://huzefanalkheda.medium.com/)

Currently building enterprise AI systems at CleverFlow (Dubai/India). IIT Ropar AI Program. 45+ production features shipped with 99.5% uptime.

## License

MIT — Huzefa Nalkheda Wala

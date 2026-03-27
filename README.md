<div align="center">

# Claude Code Optimizer

### Stop burning tokens. Start shipping faster.

[![npm version](https://img.shields.io/npm/v/claude-code-optimizer.svg?style=for-the-badge&color=CB3837)](https://www.npmjs.com/package/claude-code-optimizer)
[![npm downloads](https://img.shields.io/npm/dm/claude-code-optimizer.svg?style=for-the-badge&color=blue)](https://www.npmjs.com/package/claude-code-optimizer)
[![GitHub stars](https://img.shields.io/github/stars/huzaifa525/claude-code-optimizer?style=for-the-badge&color=gold)](https://github.com/huzaifa525/claude-code-optimizer/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![GitHub forks](https://img.shields.io/github/forks/huzaifa525/claude-code-optimizer?style=for-the-badge&color=teal)](https://github.com/huzaifa525/claude-code-optimizer/network/members)

**The #1 toolkit to make Claude Code faster, cheaper, and smarter.**
25 skills | 6 rules | 13 hooks | 2 templates — one install.

[Get Started](#-quick-start) | [What's New in v4](#-whats-new-in-v4) | [Skills](#-skills-25-slash-commands) | [Author](#-meet-the-author)

</div>

---

<div align="center">

### Built by [Huzefa Nalkheda Wala](https://huzefanalkhedawala.in/) — AI Product Engineer & Medical AI Researcher

[![Website](https://img.shields.io/badge/Website-huzefanalkhedawala.in-4285F4?style=flat-square&logo=google-chrome&logoColor=white)](https://huzefanalkhedawala.in/)
[![GitHub](https://img.shields.io/badge/GitHub-huzaifa525-181717?style=flat-square&logo=github)](https://github.com/huzaifa525)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-huzefanalkheda-0A66C2?style=flat-square&logo=linkedin)](https://linkedin.com/in/huzefanalkheda)
[![HuggingFace](https://img.shields.io/badge/HuggingFace-huzaifa525-FFD21E?style=flat-square&logo=huggingface)](https://huggingface.co/huzaifa525)
[![Medium](https://img.shields.io/badge/Medium-huzefanalkheda-000000?style=flat-square&logo=medium)](https://huzefanalkheda.medium.com/)

</div>

---

## The Problem

Every Claude Code session starts the same way — Claude explores your codebase from scratch. It runs 15-40 tool calls just to orient itself, re-reads the same files, misses your conventions, and burns tokens on discovery instead of doing actual work.

**You're paying for exploration, not engineering.**

## The Fix

Claude Code Optimizer gives Claude a **compass instead of a GPS** — a layered context system that loads just enough structure, only when relevant.

| | Without Optimizer | With Optimizer |
| :--- | :---: | :---: |
| Tool calls per task | ~20-40 | ~5-10 |
| Session start | Full exploration | Targeted reads |
| Conventions | No awareness | Follows your patterns |
| Architecture | Re-discovers every time | Knows the map |
| Session memory | Forgets everything | Remembers last session |
| **Always-on token overhead** | **Unbounded** | **~300 tokens** |

> One install. Zero config. Immediate savings.

---

## What's New in v4

| Feature | What It Does |
| :--- | :--- |
| **Two-Stage Code Review** | `/review` now checks spec compliance first, then code quality — "Did you build the right thing?" before "Did you build it well?" |
| **Anti-Rationalization** | `/tdd`, `/review`, and `/security-scan` now include iron laws, excuse tables, and loophole closure — inspired by [obra/superpowers](https://github.com/obra/superpowers) |
| **Progressive Disclosure** | `/explore-area` uses 3 layers (file index -> entry points -> deep dive) for ~10x token savings on exploration |
| **Persistent Session Memory** | Session summaries saved to `~/.claude/sessions/` and injected on next start — Claude remembers what you worked on last |
| **Subagent-Driven Development** | `/subagent-dev` dispatches fresh subagents per task with two-stage review — controller never writes code directly |
| **Git Worktree Isolation** | `/worktree` creates isolated workspaces for safe development with verified test baselines |
| **Optimization Modes** | `/mode aggressive\|balanced\|thorough` — tune token-saving behavior for the task at hand |
| **Auto-Upgrade** | `npm i -g claude-code-optimizer@latest` now auto-detects version changes and updates all files seamlessly |
| **CSO-Optimized Descriptions** | All 25 skill descriptions rewritten as triggering conditions — Claude discovers the right skill more reliably |
| **Plugin Marketplace** | `.claude-plugin/` manifest added for plugin marketplace discovery |

---

## Quick Start

Install it — everything sets up automatically.

### npm (Windows, Mac, Linux)

```bash
npm i -g claude-code-optimizer
```

That's it. Skills, rules, hooks, and templates are installed to `~/.claude/` automatically.

### Upgrading from v3?

Just reinstall — the installer auto-detects your old version and updates everything:

```bash
npm i -g claude-code-optimizer@latest
```

All your skills, hooks, rules, and settings are updated seamlessly. Or force-update anytime:

```bash
npx claude-code-optimizer --update
```

### curl (Mac, Linux, WSL)

```bash
curl -sL https://raw.githubusercontent.com/huzaifa525/claude-code-optimizer/main/scripts/install.sh | bash
```

### PowerShell (Windows — no Node.js needed)

```powershell
irm https://raw.githubusercontent.com/huzaifa525/claude-code-optimizer/main/scripts/install.ps1 | iex
```

### Uninstall

```bash
# npm
npx claude-code-optimizer --uninstall

# curl
curl -sL https://raw.githubusercontent.com/huzaifa525/claude-code-optimizer/main/scripts/uninstall.sh | bash
```

### Post-Install

Copy the templates to your project and fill in your details:

```bash
cp ~/.claude/CLAUDE.md.template ./CLAUDE.md
cp ~/.claude/claudeignore.template ./.claudeignore
```

---

## What You Get

| Type | Count | Installed To | Purpose |
| :--- | :---: | :--- | :--- |
| Skills | 25 | `~/.claude/skills/` | Slash commands for every workflow |
| Rules | 6 | `~/.claude/rules/` | Path-scoped conventions that auto-load |
| Hooks | 13 | `~/.claude/hooks/` | Automation scripts that run on their own |
| Templates | 2 | `~/.claude/` | CLAUDE.md + .claudeignore starters |
| Sessions | - | `~/.claude/sessions/` | Persistent memory across restarts |

---

## Skills (25 Slash Commands)

Skills are commands you invoke inside Claude Code with `/skill-name`. They run as specialized prompts that guide Claude to work smarter.

#### Exploration & Context

| Skill | Purpose | How to Invoke |
| :--- | :--- | :--- |
| `/explore-area` | Deep codebase exploration with progressive disclosure | `/explore-area src/api/` |
| `/gen-context` | Generate fresh project context summary | `/gen-context` |
| `/onboard` | Full onboarding guide for new developers | `/onboard` |
| `/token-check` | Session token usage analysis | `/token-check` |
| `/optimize-tokens` | Web search for latest optimization tips + project analysis | `/optimize-tokens` |

#### Development Workflow

| Skill | Purpose | How to Invoke |
| :--- | :--- | :--- |
| `/planning` | Persistent markdown planning for complex tasks | Auto-activates on complex tasks |
| `/plan` | Create implementation plan with task breakdown | `/plan Add user notifications` |
| `/smart-edit` | Pattern-aware code changes | `/smart-edit Add delete endpoint` |
| `/tdd` | Test-Driven Development with anti-rationalization | `/tdd user login validation` |
| `/fix-issue` | Fetch GitHub issue, implement fix, test, commit | `/fix-issue 42` |
| `/debug-error` | Analyze error, find root cause, fix | `/debug-error Cannot read property of undefined` |
| `/refactor` | Refactor code while preserving behavior | `/refactor auth middleware` |
| `/migrate` | Migrate between frameworks/versions | `/migrate React-Router-v5 React-Router-v6` |
| `/worktree` | Isolated git worktree for safe development | `/worktree user-notifications` |
| `/subagent-dev` | Dispatch fresh subagents per task with review | `/subagent-dev` |

#### Git & GitHub

| Skill | Purpose | How to Invoke |
| :--- | :--- | :--- |
| `/commit` | Generate conventional commit message and commit | `/commit` |
| `/create-pr` | Create PR with auto-generated description | `/create-pr` |
| `/changelog` | Generate changelog from git history | `/changelog` |

#### Code Quality & Security

| Skill | Purpose | How to Invoke |
| :--- | :--- | :--- |
| `/review` | Two-stage review: spec compliance then code quality | `/review` |
| `/security-scan` | OWASP top 10, secrets, injection scan with anti-rationalization | `/security-scan` |
| `/perf-check` | N+1 queries, memory leaks, bundle size analysis | `/perf-check src/api/` |
| `/dep-check` | Outdated/vulnerable dependency check | `/dep-check` |
| `/document` | Generate docs/JSDoc/docstrings | `/document src/utils/` |

#### Optimization

| Skill | Purpose | How to Invoke |
| :--- | :--- | :--- |
| `/mode` | Switch optimization mode (aggressive/balanced/thorough) | `/mode aggressive` |
| `/setup` | Auto-generate CLAUDE.md and .claudeignore for project | `/setup` |

---

### Skill Deep Dives

<details>
<summary><strong>/explore-area [directory]</strong> — Progressive disclosure exploration</summary>

Uses a 3-layer approach to minimize token cost:

1. **Layer 1 (File Index)** — List files without reading contents. Often enough.
2. **Layer 2 (Entry Points)** — Read index files and grep for exports/signatures.
3. **Layer 3 (Deep Dive)** — Read full files only where needed, with offset/limit.

Runs in a forked subagent so exploration tokens don't pollute your main context.

```
/explore-area src/api/
/explore-area src/components/
```

**Example output:**

```
## Area: src/api/

### Structure (12 files)
- routes/index.ts → route registration
- middleware/auth.ts → JWT validation

### Patterns to Follow
- One file per resource in routes/
- Zod validation at route level

### Gotchas
- auth middleware is duplicated intentionally (different token validation)
```

</details>

<details>
<summary><strong>/review</strong> — Two-stage code review</summary>

**Stage 1: Spec Compliance** — Does the code do what was intended? Checks intent against implementation, verifies all requirements are met, confirms correct files were modified. Must pass before Stage 2.

**Stage 2: Code Quality** — Is the code well-written? Checks security, performance, code quality, and convention compliance.

Includes anti-rationalization: a table of common excuses ("this is just a small change") with rebuttals ("small changes cause big bugs"). Runs in a forked subagent.

</details>

<details>
<summary><strong>/tdd [feature]</strong> — Test-Driven Development with iron laws</summary>

Strict RED-GREEN-REFACTOR with three iron laws:

1. **No production code without a failing test.** Write code before test? DELETE it.
2. **Write MINIMUM code to pass.** If the test passes, STOP.
3. **Delete means delete.** Don't keep as reference. Don't adapt it. Don't look at it.

Includes anti-rationalization table for common TDD excuses.

```
/tdd user login validation
```

</details>

<details>
<summary><strong>/worktree [branch-name]</strong> — Isolated git worktree development</summary>

Creates a git worktree for safe, isolated development:

1. Verifies clean baseline (no uncommitted changes)
2. Creates worktree on a new branch
3. Runs tests BEFORE any changes to verify baseline
4. All work happens in isolation
5. Presents merge/PR/keep/discard options when done

```
/worktree user-notifications
/worktree fix-auth-bug
```

</details>

<details>
<summary><strong>/subagent-dev</strong> — Dispatch fresh subagents per task</summary>

Inspired by [obra/superpowers](https://github.com/obra/superpowers). The controller (Claude) coordinates but never writes code directly:

1. Load the plan (from `task_plan.md` or user's task list)
2. For each task: dispatch implementer subagent → spec reviewer → quality reviewer
3. Handle status: DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT, BLOCKED
4. Verify all tests pass at the end

Each subagent gets fresh context — no pollution from previous tasks.

</details>

<details>
<summary><strong>/mode [aggressive|balanced|thorough]</strong> — Optimization profiles</summary>

| Mode | Thinking Budget | Best For |
| :--- | :---: | :--- |
| **Aggressive** | 4K tokens | Routine edits, simple bug fixes |
| **Balanced** | 10K tokens | General development (default) |
| **Thorough** | 32K tokens | Complex debugging, architecture, security |

```
/mode aggressive   # maximum savings
/mode thorough     # maximum context
/mode balanced     # back to default
```

</details>

<details>
<summary><strong>/security-scan</strong> — OWASP vulnerability scan with anti-rationalization</summary>

Scans for OWASP top 10 vulnerabilities — hardcoded secrets, SQL injection, XSS, command injection, missing auth, insecure configs, dependency vulnerabilities. Returns a severity-ranked report.

**Iron Law:** No "probably safe." Verify or flag. False positives are cheap. Missed vulnerabilities are not.

Includes anti-rationalization for common security excuses ("this is internal code", "we're behind a firewall", "we'll fix it later"). Runs in a forked subagent.

</details>

<details>
<summary><strong>/gen-context</strong> — Fresh project context in seconds</summary>

Analyzes package.json, project structure, entry points, framework, git history, and existing CLAUDE.md. Gives Claude a full picture without you explaining it.

```
/gen-context
```

</details>

<details>
<summary><strong>/smart-edit [what to change]</strong> — Pattern-aware code changes</summary>

Before making any change, it finds similar existing code in your codebase, reads at least 2 examples of the same pattern, checks conventions, then implements matching your exact style.

```
/smart-edit Add a delete endpoint for users
/smart-edit Add dark mode toggle to settings page
/smart-edit Create a new database migration for adding email field
```

</details>

<details>
<summary><strong>/token-check</strong> — Session health report</summary>

Analyzes your current session for token efficiency — context usage, MCP servers, conversation length, and optimization tips.

```
/token-check
```

**Example output:**

```
Session Health Report
---------------------
Context usage: ~120K / 200K
Conversation turns: 23
Suggested action: /compact
Optimization tips:
- 3 files read multiple times (users.ts, auth.ts, db.ts)
- 2 MCP servers unused this session
- CLAUDE.md is 340 lines (recommend < 200)
```

</details>

<details>
<summary><strong>/planning</strong> — Persistent task tracking</summary>

Automatically creates `task_plan.md` for complex tasks. Breaks work into steps, tracks progress with checkboxes, and survives across sessions. **Auto-activates** when a task requires 5+ steps.

</details>

<details>
<summary><strong>/commit</strong> — Smart conventional commits</summary>

Analyzes staged changes (`git diff --cached`), checks your recent commit style, and generates a conventional commit message (feat:, fix:, refactor:, etc.). Stage your changes with `git add`, then type `/commit`.

</details>

<details>
<summary><strong>/create-pr</strong> — Auto-generated PRs</summary>

Analyzes ALL commits on your branch (not just the latest), generates a PR title, summary bullets, change list, and test plan checklist. Pushes and creates the PR via `gh`.

</details>

<details>
<summary><strong>/fix-issue [number]</strong> — End-to-end issue resolution</summary>

Fetches a GitHub issue, creates a branch, finds relevant code, implements the fix, writes tests, runs them, and commits with the issue number.

```
/fix-issue 42
```

</details>

<details>
<summary><strong>/debug-error [error]</strong> — Root cause analysis</summary>

Parses an error message or stack trace, traces the root cause through the codebase, checks recent git changes, implements a fix, and verifies.

</details>

<details>
<summary><strong>/refactor [target]</strong> — Safe refactoring</summary>

Runs tests first to establish a baseline, then refactors incrementally. After each change, runs tests again. If anything breaks, reverts immediately.

</details>

<details>
<summary><strong>/perf-check [target]</strong> — Performance analysis</summary>

Analyzes for N+1 queries, memory leaks, unnecessary re-renders, large bundle imports, missing caching, O(n^2) algorithms, and more. Runs in a forked subagent.

</details>

<details>
<summary><strong>/dep-check</strong> — Dependency audit</summary>

Runs `npm audit` / `pip audit`, checks for outdated packages, flags deprecated dependencies, and suggests upgrades with breaking change warnings.

</details>

<details>
<summary><strong>/changelog</strong> — Auto-generated changelogs</summary>

Generates a changelog from git history since the last tag. Groups commits by type (features, fixes, breaking changes). Outputs or updates CHANGELOG.md.

</details>

<details>
<summary><strong>/migrate [from] [to]</strong> — Framework migration</summary>

Greps for all usages of the old API/library, creates a migration plan, applies changes file by file, runs tests after each file, and reports what couldn't be auto-migrated.

```
/migrate Express-v4 Express-v5
/migrate React-Router-v5 React-Router-v6
```

</details>

<details>
<summary><strong>/onboard</strong> — New developer guide</summary>

Generates a complete onboarding guide — project structure, tech stack, dev workflow, code conventions, common tasks, environment variables, and useful commands. Runs in a forked subagent.

</details>

<details>
<summary><strong>/plan [feature]</strong> — Implementation planning</summary>

Creates a phased implementation plan with task breakdown, file mapping, reference code pointers, dependencies, and risk assessment. Runs in a forked subagent using the Plan agent.

</details>

<details>
<summary><strong>/optimize-tokens</strong> — Token optimization tips</summary>

Searches the web for the latest Claude Code token optimization tips, then analyzes your current project setup (CLAUDE.md size, .claudeignore, rules, skills, MCP servers, settings). Returns a scored report with quick wins.

</details>

---

## Rules (Path-Scoped Guidelines)

Rules are markdown files in `~/.claude/rules/` that give Claude persistent context about your coding conventions. They use **path-scoping** — each rule only loads when Claude reads files matching specific patterns, so you don't waste tokens on irrelevant context.

| Rule | Activates When Claude Reads | What It Tells Claude |
| :--- | :--- | :--- |
| `frontend.md` | `src/components/**`, `src/pages/**`, `**/*.tsx`, `**/*.jsx` | Component structure, styling approach, patterns to follow, what NOT to do |
| `backend.md` | `src/api/**`, `src/routes/**`, `src/controllers/**`, `src/services/**` | API structure (routes -> controllers -> services), endpoint patterns, error handling |
| `database.md` | `src/database/**`, `src/models/**`, `prisma/**`, `**/*.sql` | ORM usage, migration rules, query patterns, safety rules |
| `testing.md` | `**/*.test.*`, `**/*.spec.*`, `tests/**` | Test runner, file conventions, what to test, what NOT to test |
| `skill-router.md` | Always active | Maps user intents to skills — "commit this" -> `/commit`, "review" -> `/review`, etc. |
| `token-optimization.md` | Always active | Thinking caps, model selection, compaction strategy, duplicate read prevention |

**How it works:** You edit these files with your actual conventions. When Claude opens a `.tsx` file, `frontend.md` loads automatically. When Claude is working on backend code, frontend rules stay hidden — zero token cost.

### How to customize rules

```bash
# Edit any rule
code ~/.claude/rules/frontend.md

# Add a new rule
code ~/.claude/rules/security.md
```

Add `paths:` frontmatter to scope when it loads:

```yaml
---
paths:
  - "src/api/**"
  - "**/*.ts"
---

Your rules here...
```

---

## Hooks (Automation Scripts)

Hooks are shell scripts that run automatically at specific moments in Claude Code's lifecycle. They don't need to be invoked — they trigger on their own.

| Hook | Triggers On | What It Does |
| :--- | :--- | :--- |
| `generate-context.sh` | Every session start | Injects recent commits, uncommitted changes, branch into context |
| `memory-inject.sh` | Every session start | Injects last session's summary for persistent memory across restarts |
| `resume-plan.sh` | Every session start | Detects task_plan.md and injects it so `/planning` continues across sessions |
| `auto-setup.sh` | Every session start | Auto-generates `CLAUDE.md` and `.claudeignore` if missing — detects stack, framework, entry points |
| `auto-update-check.sh` | Every session start (once/day) | Checks for new optimizer version and notifies you |
| `protect-files.sh` | Every file edit/write | Blocks edits to `.env`, credentials, lock files, `.git/`, private keys |
| `block-dangerous.sh` | Every bash command | Blocks `rm -rf /`, `git push --force main`, `DROP TABLE`, etc. |
| `auto-format.sh` | After every file edit | Auto-runs prettier/black/gofmt/rustfmt on edited files |
| `filter-test-output.sh` | After test/build/lint commands | Filters verbose output (50+ lines) to summary only |
| `track-activity.sh` | After every tool use | Lightweight activity logger for session awareness |
| `commit-reminder.sh` | When Claude stops responding | Reminds about uncommitted changes, suggests `/commit` |
| `session-summary.sh` | When Claude stops responding | Captures what was accomplished and saves to `~/.claude/sessions/` |
| `token-savings-footer.sh` | Every 5th response | Shows estimated token savings this session |

<details>
<summary><strong>Hook details</strong></summary>

#### Persistent Session Memory

Three hooks work together to give Claude memory across sessions:

1. **`track-activity.sh`** (PostToolUse) — Logs tool usage timestamps during the session
2. **`session-summary.sh`** (Stop) — Captures git changes, commits, and activity count into `~/.claude/sessions/`
3. **`memory-inject.sh`** (SessionStart) — Injects the last session's summary so Claude knows what you worked on

No database needed — just lightweight markdown files.

#### `protect-files.sh`

Prevents accidental edits to files that should never be touched by AI.

| Category | Files |
| :--- | :--- |
| Environment | `.env`, `.env.local`, `.env.production` |
| Credentials | `credentials.json`, `*.pem`, `*.key` |
| Lock files | `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml` |
| Git | `.git/` directory |

#### `filter-test-output.sh`

Test output can be thousands of lines. This saves massive token waste by only feeding Claude the information it actually needs (what passed, what failed). Full output stays in your terminal.

</details>

### How to activate hooks

Add to your project's `.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/generate-context.sh" },
          { "type": "command", "command": "bash ~/.claude/hooks/memory-inject.sh" }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/hooks/protect-files.sh" }
        ]
      }
    ]
  }
}
```

---

## How It All Works Together

| Stage | What Happens | Token Cost |
| :--- | :--- | :---: |
| **Session Start** | `generate-context.sh` + `memory-inject.sh` — Claude sees recent commits, changes, branch, and last session | ~300 |
| **Always Loaded** | `CLAUDE.md` loads — Claude sees commands, entry points, flow diagrams, decisions | ~200 |
| **Always Active** | `.claudeignore` blocks node_modules, dist, lock files, .env from being read | 0 |
| **On-Demand** | Rules load based on what files Claude reads (frontend.md, backend.md, etc.) | ~500 when active |
| **Auto Planning** | `planning` skill activates on complex tasks — creates task_plan.md | ~200 |
| **User Invoked** | 25 skills for commits, reviews, PRs, debugging, security, worktrees, etc. | 0 in main context (forked) |
| **Every Edit** | `protect-files.sh` guards .env, credentials, lock files | ~10 |
| **Session End** | `session-summary.sh` saves what was accomplished for next session | 0 (background) |

**Total always-on overhead: ~500 tokens.** Everything else loads only when needed.

---

## Optimization Strategies

| Strategy | Token Savings | Effort |
| :--- | :---: | :---: |
| Lean CLAUDE.md with entry points | ~30% | Low |
| Path-scoped rules | ~20% | Medium |
| `.claudeignore` | ~15% | Low |
| Progressive disclosure exploration (forked) | ~25% | Low |
| Session start hooks + memory | ~10% | Medium |
| Code annotations (`@claude` tags) | ~15% | Medium |
| `/mode aggressive` | ~40% | Low |
| Anti-rationalization in skills | ~10% | Low |

---

## Stack Templates

The `examples/` directory includes ready-to-use CLAUDE.md templates for popular stacks:

| Stack | Framework | Key Features |
| :--- | :--- | :--- |
| **Next.js App** | Next.js 14, App Router | Server Actions, Prisma, Tailwind |
| **Express API** | Express.js | REST, Controllers, Services, JWT Auth |
| **Python FastAPI** | FastAPI | SQLAlchemy, Alembic, Pydantic v2 |
| **Monorepo** | Turborepo | pnpm workspaces, shared packages |

Browse them on [GitHub](https://github.com/huzaifa525/claude-code-optimizer/tree/main/examples).

---

## Star History

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=huzaifa525/claude-code-optimizer&type=Date)](https://star-history.com/#huzaifa525/claude-code-optimizer&Date)

</div>

If this tool saves you tokens (and money), consider giving it a star — it helps others find it too.

---

## Contributing

We welcome contributions! Whether it's a new skill, a stack-specific template, or a bug fix:

1. Fork the repo
2. Create your feature branch
3. Submit a PR

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## Meet the Author

<div align="center">

### Huzefa Nalkheda Wala

**AI Product Engineer | Medical AI Researcher | Open Source Builder**

</div>

Building enterprise AI systems at **Ruby CRM / CleverFlow** (Dubai) — 45+ production features shipped with 99.5% uptime. Passionate about making AI-assisted development faster and more accessible for every developer.

| | |
| :--- | :--- |
| Website | [huzefanalkhedawala.in](https://huzefanalkhedawala.in/) |
| GitHub | [@huzaifa525](https://github.com/huzaifa525) |
| LinkedIn | [huzefanalkheda](https://linkedin.com/in/huzefanalkheda) |
| HuggingFace | [huzaifa525](https://huggingface.co/huzaifa525) |
| Medium | [huzefanalkheda](https://huzefanalkheda.medium.com/) |
| npm | [claude-code-optimizer](https://www.npmjs.com/package/claude-code-optimizer) |

**Other projects:** Check out my [GitHub](https://github.com/huzaifa525) for more AI/ML tools and research.

---

<div align="center">

**If Claude Code Optimizer saves you time and money, [star the repo](https://github.com/huzaifa525/claude-code-optimizer) and share it with your team.**

MIT License -- Huzefa Nalkheda Wala

</div>

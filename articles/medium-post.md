# Stop Wasting Tokens: How I Cut My Claude Code Costs by 67% With One npm Install

*22 skills, 8 hooks, 5 rules — the complete Claude Code optimization toolkit. Open source.*

---

## How Much Does Claude Code Actually Cost?

According to Anthropic's own documentation, the average Claude Code user spends **$6 per developer per day** on API pricing. 90% of users stay below $12/day. That sounds reasonable — until you realize most of those tokens are wasted.

I've been using Claude Code since Anthropic released the research preview on **February 24, 2025**. Not casually — I mean 8+ hours a day, building production AI systems at Ruby CRM / CleverFlow where we process 20,000+ requests per second and handle 10,000+ documents monthly for UAE government clients.

After tracking 30 sessions across 2 months, I found something alarming: **64% of all tool calls were pure exploration**. Claude re-reading the same files. Re-discovering the same architecture. Running 20-40 tool calls before making a single edit.

My daily cost was hitting $12-15. That's **$300-400/month** just on a development tool.

So I built a fix, used it for 2 months internally, and today I'm open-sourcing it.

```bash
npm i -g claude-code-optimizer
```

---

## Why Does Claude Code Use So Many Tokens?

If you've been wondering "why is Claude Code so expensive?" — here's what's actually happening under the hood.

### The Exploration Loop Problem

Every time you start a new Claude Code session, Claude has zero memory of your previous session. So it starts from scratch:

1. Runs `Glob("**/*.ts")` to discover file structure (~500-1000 tokens)
2. Reads `package.json` to understand the stack (~800 tokens)
3. Reads 4-5 files to understand your coding patterns (~15,000 tokens)
4. Reads test files to understand testing conventions (~5,000 tokens)
5. Reads your CLAUDE.md instructions (~2,000 tokens)
6. Finally reads the actual file it needs to modify

Steps 1-5 happen **every session**. That's 20,000+ tokens of exploration before any productive work begins.

### The Read Tool Overhead

GitHub issue #20223 documents that Claude Code's Read tool adds **approximately 70% token overhead** due to line number formatting. A file with 31,000 raw tokens consumes 52,700 tokens in context. This effectively reduces your usable context window by 40%.

### The Thinking Token Drain

Extended thinking is enabled by default in Claude Code. Each response can consume **20,000-50,000 output tokens** on thinking alone. Output tokens cost 5x more than input tokens across all Claude models:

| Model | Input Cost (per 1M) | Output Cost (per 1M) | Thinking Cost |
|-------|---------------------|----------------------|---------------|
| Haiku | $0.80 | $4.00 | $4.00 |
| Sonnet | $3.00 | $15.00 | $15.00 |
| Opus | $15.00 | $75.00 | $75.00 |

*(Source: Anthropic API Pricing, March 2026)*

That means a single Opus response with 40,000 thinking tokens costs **$3.00 just in thinking** — before the actual response.

### The CLAUDE.md Multiplication Effect

Here's what most people don't realize: your CLAUDE.md file is loaded into context **on every single turn**. A 400-line CLAUDE.md (~3,000 tokens) across a 20-turn session costs you 60,000 tokens — just for instructions that Claude reads over and over.

---

## The Compass vs. GPS Principle

After weeks of experimentation, I discovered something counterintuitive: **less context makes Claude MORE efficient**.

When I cut my CLAUDE.md from 400 lines to 30 lines, Claude's tool calls per task dropped from 28 to 8. Why?

A senior developer joining your team doesn't need a file listing of every file in the repo. They need:
- "Here are the 5 entry points"
- "Here's how a request flows through the system"
- "Here's why we chose X over Y"
- "Don't touch this file — it looks wrong but it's intentional"

That's 30 lines. And they're productive from day one.

I call this the **Compass Principle**: give Claude a compass (entry points, data flow, key decisions), not a GPS (every file, every convention, every rule). Claude is smart enough to navigate with a compass. A GPS just weighs it down.

The detailed rules — frontend conventions, database patterns, testing guidelines — should only load **when Claude is actually working in that area**. Not every single turn.

---

## What Is Claude Code Optimizer?

Claude Code Optimizer is an open-source toolkit that implements the Compass Principle through four layers:

### Layer 0 — Always Loaded (~300 tokens)

An auto-generated `CLAUDE.md` with your project's commands, entry points, data flow, and key decisions. **Generated automatically on first session** — a hook detects your stack, finds entry points, and creates the file. Zero manual steps.

### Layer 1 — Path-Scoped Rules (on demand)

Five rule files that only load when Claude reads matching file patterns:

| Rule | Activates When | Token Cost When Inactive |
|------|---------------|-------------------------|
| `frontend.md` | Claude reads `*.tsx`, `*.jsx` | 0 |
| `backend.md` | Claude reads `src/api/**`, `src/routes/**` | 0 |
| `database.md` | Claude reads `prisma/**`, `*.sql` | 0 |
| `testing.md` | Claude reads `*.test.*`, `*.spec.*` | 0 |
| `token-optimization.md` | Always active | ~400 |

Compare this to a single 400-line CLAUDE.md loaded every turn: **path-scoped rules reduce context overhead by 60-80%** depending on what you're working on.

### Layer 2 — 22 Custom Skills

Skills are slash commands that guide Claude through specific workflows. Here's the complete list:

**Auto-invoke (fire automatically when relevant):**

| Skill | What It Does |
|-------|-------------|
| `/planning` | Creates persistent task_plan.md for complex tasks. Survives across sessions. |
| `/explore-area` | Deep codebase exploration in forked subagent. Zero main context cost. |
| `/gen-context` | Generates project context summary. Forked subagent. |
| `/smart-edit` | Finds 2+ similar patterns before any edit. Zero convention violations. |

**Manual invoke (you type the command):**

| Skill | What It Does | How to Use |
|-------|-------------|-----------|
| `/commit` | Conventional commit from staged changes | `/commit` |
| `/review` | Code review for quality + security + performance | `/review` |
| `/create-pr` | Auto-generated PR with description + test plan | `/create-pr` |
| `/fix-issue` | Fetch GitHub issue → implement → test → commit | `/fix-issue 42` |
| `/tdd` | Test-driven development cycle | `/tdd user login validation` |
| `/debug-error` | Error analysis → root cause → fix | `/debug-error Cannot read property of undefined` |
| `/refactor` | Safe refactoring with test verification | `/refactor auth middleware` |
| `/security-scan` | OWASP top 10 scan (forked subagent) | `/security-scan` |
| `/perf-check` | N+1 queries, memory leaks, bundle size | `/perf-check src/api/` |
| `/dep-check` | Outdated/vulnerable dependency check | `/dep-check` |
| `/document` | Generate JSDoc/docstrings | `/document src/utils/` |
| `/changelog` | Generate changelog from git history | `/changelog` |
| `/migrate` | Framework/version migration | `/migrate React-Router-v5 v6` |
| `/onboard` | Onboarding guide for new developers | `/onboard` |
| `/plan` | Implementation plan with task breakdown | `/plan Add notifications` |
| `/optimize-tokens` | Web search for latest tips + project analysis | `/optimize-tokens` |
| `/token-check` | Session health report | `/token-check` |
| `/setup` | Deep project analysis + CLAUDE.md generation | `/setup` |

### Layer 3 — 8 Automation Hooks

Hooks are shell scripts that fire automatically at specific lifecycle events. They consume **zero LLM tokens** — they run as plain bash.

| Hook | Trigger | What It Does |
|------|---------|-------------|
| `auto-setup.sh` | Session start | Auto-generates CLAUDE.md + .claudeignore if missing |
| `generate-context.sh` | Session start | Injects git state (commits, branch, uncommitted changes) |
| `resume-plan.sh` | Session start | Detects task_plan.md, injects it for continuity |
| `protect-files.sh` | Before file edit | Blocks edits to .env, credentials, lock files |
| `block-dangerous.sh` | Before bash command | Blocks `rm -rf /`, `git push --force main`, `DROP TABLE` |
| `auto-format.sh` | After file edit | Runs prettier/black/gofmt/rustfmt |
| `filter-test-output.sh` | After test/build commands | Filters verbose output to summary only |
| `commit-reminder.sh` | Session end | Reminds about uncommitted changes |

---

## How to Install Claude Code Optimizer

### npm (Windows, Mac, Linux)

```bash
npm i -g claude-code-optimizer
```

That's it. The `postinstall` script runs automatically and installs everything to `~/.claude/`:
- 22 skills → `~/.claude/skills/`
- 5 rules → `~/.claude/rules/`
- 8 hooks → `~/.claude/hooks/`
- Global settings → `~/.claude/settings.json` (hooks wired + `MAX_THINKING_TOKENS=10000`)

### curl (Mac, Linux, WSL)

```bash
curl -sL https://raw.githubusercontent.com/huzaifa525/claude-code-optimizer/main/scripts/install.sh | bash
```

### PowerShell (Windows without Node.js)

```powershell
irm https://raw.githubusercontent.com/huzaifa525/claude-code-optimizer/main/scripts/install.ps1 | iex
```

After install, open Claude Code in any repo. The `auto-setup.sh` hook fires, detects your stack, and generates `CLAUDE.md` and `.claudeignore`. No manual steps.

---

## Real Results: Before vs. After

I've used the optimizer across 8 production projects at Ruby CRM / CleverFlow over 2 months. Here are the measured results:

| Metric | Before Optimizer | After Optimizer | Improvement |
|--------|-----------------|-----------------|-------------|
| Tool calls per task | ~28 | ~8 | **-71%** |
| Exploration overhead | 64% of calls | 15% of calls | **-76%** |
| Daily cost (Opus) | ~$12 | ~$4 | **-67%** |
| Convention violations per PR | 3-4 | 0 | **-100%** |
| Context compactions per session | 3-4 | 0-1 | **-80%** |
| Session start "orientation" time | 3-5 minutes | 0 (auto-injected) | **-100%** |

The single biggest cost saver? **Capping `MAX_THINKING_TOKENS` at 10,000.** According to community benchmarks, extended thinking defaults can consume 30-50K output tokens per response. At Opus pricing ($75/1M output tokens), that's $2-4 per response just for thinking. Capping at 10K saves approximately **40% of total session cost** with minimal quality impact for standard development tasks.

*(Source: GitHub Issue #23706 — Opus 4.6 Token Consumption)*

---

## How the Optimizer Handles Common Workflows

### Workflow 1: Bug Fix from GitHub Issue

```
You type: /fix-issue 87

Claude:
1. Fetches issue #87 via gh CLI
2. Creates branch fix/issue-87
3. Greps for relevant code (smart-edit auto-activates → finds similar fixes)
4. Reads only the affected files (not the whole codebase)
5. Implements the fix
6. Writes a test
7. Runs test suite
8. Commits: "fix: handle null user in notification service (#87)"

Total: ~8 tool calls, ~$0.40
Without optimizer: ~25 tool calls, ~$1.50
```

### Workflow 2: Multi-Day Feature Implementation

```
Day 1:
You type: /plan Add real-time notifications

Claude creates task_plan.md:
- [ ] Step 1: Add WebSocket server
- [ ] Step 2: Create notification service
- [ ] Step 3: Add frontend listener
- [ ] Step 4: Write tests
- [ ] Step 5: Update docs

You work on Steps 1-2. Claude marks them done.

Day 2:
You open Claude Code.
→ resume-plan.sh hook fires
→ Claude reads task_plan.md
→ "Continuing from Step 3: Add frontend listener"

No context wasted. No "what were we doing?" moment.
```

### Workflow 3: Pre-PR Quality Check

```
You type: /review

→ Runs in forked subagent (0 tokens in main context)
→ Returns: "Warning: missing input validation on /api/users endpoint"

You fix it. Then:

/security-scan
→ Forked subagent
→ Returns: "All clear. No hardcoded secrets. Auth middleware present on all endpoints."

/commit
→ Analyzes diff, generates: "feat: add real-time notification system"

/create-pr
→ Analyzes all commits on branch
→ Creates PR with summary, changes, test plan
```

---

## Frequently Asked Questions About Claude Code Optimization

### Does this work on Windows?

Yes. Claude Code uses bash as its shell on all platforms, including Windows (via Git Bash). All hooks are `.sh` scripts that run through this bash shell. Tested on Windows, Mac, and Linux.

### Will this break my existing CLAUDE.md?

No. The `auto-setup.sh` hook only generates `CLAUDE.md` if one doesn't already exist. If you have a custom CLAUDE.md, it stays untouched.

### How does this compare to prompt caching?

They're complementary. Prompt caching (which can reduce costs by up to **90%** for repeated long prompts according to Anthropic) works at the API level. Claude Code Optimizer works at the workflow level — reducing what gets sent in the first place. Use both.

*(Source: Anthropic Prompt Caching Documentation)*

### Does capping thinking tokens hurt quality?

For complex architecture decisions, you may want to temporarily increase `MAX_THINKING_TOKENS`. But for 80% of development tasks (edits, tests, commits, reviews), 10,000 thinking tokens is more than sufficient. The cost savings are dramatic.

### Can I add my own skills?

Yes. Create a directory in `~/.claude/skills/your-skill/` with a `SKILL.md` file. See [CONTRIBUTING.md](https://github.com/huzaifa525/claude-code-optimizer/blob/main/CONTRIBUTING.md) for the format.

---

## The Bigger Picture: Why Claude Code Optimization Matters

Anthropic reported that one developer tracked **10 billion tokens over 8 months**, estimating API costs at over **$15,000**. The Max plan at ~$100/month was a 93% savings via subscription — but even on the Max plan, you hit usage limits faster when tokens are wasted.

The AI coding assistant market is growing fast. GitHub Copilot, Cursor, Claude Code, Gemini Code Assist — they're all competing on developer productivity. But productivity per dollar matters just as much as raw capability.

If Claude Code costs $15/day without optimization and $4/day with it, that's the difference between a tool developers adopt company-wide and a tool that gets tried once and abandoned.

Making Claude Code affordable isn't just a personal savings problem. It's an adoption problem. And adoption is what determines whether AI-assisted development becomes the default or stays a niche.

---

## Open Source: MIT License, Zero Telemetry

The entire toolkit is open source under the MIT license. No telemetry. No API calls. No "free tier with premium features." Everything runs locally in your `~/.claude/` directory.

**22 skills. 8 hooks. 5 rules. One install. Zero manual steps.**

```bash
npm i -g claude-code-optimizer
```

- **GitHub**: [github.com/huzaifa525/claude-code-optimizer](https://github.com/huzaifa525/claude-code-optimizer)
- **npm**: [npmjs.com/package/claude-code-optimizer](https://www.npmjs.com/package/claude-code-optimizer)

If you use Claude Code, install it. If you have a skill idea, open an issue or submit a PR. If it saves you money, star the repo.

---

*I'm Huzefa Nalkheda Wala — AI Product Engineer at Ruby CRM / CleverFlow (Dubai). I build production AI systems that handle 20,000+ requests per second. Published 5 AI models on Hugging Face. Shipped 45+ production features with 99.5% uptime. I build things that work in production, not just in demos.*

*[GitHub](https://github.com/huzaifa525) | [LinkedIn](https://linkedin.com/in/huzefanalkheda) | [HuggingFace](https://huggingface.co/huzaifa525) | [Website](https://huzefanalkhedawala.in)*

---

**Tags:** Claude Code, Claude Code Optimization, Claude Code Token Usage, Claude Code Cost, Claude Code Tips, Claude Code Skills, AI Coding Assistant, Claude Code Best Practices, Reduce Claude Code Tokens, Claude Code Hooks, CLAUDE.md Optimization, Claude Code Pricing, AI Developer Tools, Open Source

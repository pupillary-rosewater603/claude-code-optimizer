# Optimization Strategies

> By [Huzefa Nalkheda Wala](https://huzefanalkhedawala.in/) | [GitHub](https://github.com/huzaifa525)

A complete reference of every strategy for reducing Claude Code token usage and improving response quality.

---

## Strategy 1: Lean CLAUDE.md with Entry Points

**Impact: High | Effort: Low**

Instead of describing every file, list 5-6 entry points that connect everything. Claude reads one index file and discovers the whole system.

```markdown
## Entry Points
- src/routes/index.ts  → all routes registered here
- src/models/index.ts  → all models exported here
- src/config/index.ts  → all config centralized
```

**Why it works:** Entry points are natural maps. One `Read` call reveals the entire module structure through imports.

---

## Strategy 2: Path-Scoped Rules

**Impact: High | Effort: Medium**

Rules with `paths:` frontmatter only load when Claude reads matching files. No wasted tokens on irrelevant context.

```yaml
---
paths:
  - "src/api/**"
---
# Only loads when Claude is working on API files
```

**Why it works:** A backend-only task never loads frontend rules. A test-only task never loads deployment rules.

---

## Strategy 3: .claudeignore

**Impact: Medium | Effort: Low**

Prevent Claude from reading files that are never useful — build artifacts, lock files, binary assets, node_modules.

**Why it works:** Claude sometimes Globs broadly and reads irrelevant files. `.claudeignore` prevents this at the tool level.

---

## Strategy 4: Forked Exploration Skills

**Impact: High | Effort: Low**

Run exploration in a `context: fork` subagent. The subagent reads 20 files, processes them, and returns a 50-line summary. Your main context only sees the summary.

```yaml
---
context: fork
agent: Explore
---
```

**Why it works:** File contents from exploration enter the subagent's context (discarded after), not yours. You get the insight without the token cost.

---

## Strategy 5: Session Start Hooks

**Impact: Medium | Effort: Medium**

Auto-inject fresh git state (recent commits, uncommitted changes, current branch) when a session starts. Claude knows what you've been working on without asking.

**Why it works:** Eliminates the "what's the current state?" exploration that happens at the start of every session.

---

## Strategy 6: Code Annotations (@claude tags)

**Impact: Medium | Effort: Medium**

Add searchable tags in source code that Claude can Grep for:

```typescript
// @claude-entry: All routes registered here
// @claude-pattern: Follow this for new endpoints
// @claude-warning: Auto-generated, do not edit
```

**Why it works:** One `Grep("@claude-pattern")` finds every example Claude needs to follow, instead of reading 10 files to find one pattern.

---

## Strategy 7: Cap Extended Thinking

**Impact: Very High | Effort: Low**

Set `MAX_THINKING_TOKENS=10000` in your Claude Code settings. Extended thinking can burn 20-50K output tokens per response otherwise.

```json
{
  "env": {
    "MAX_THINKING_TOKENS": "10000"
  }
}
```

**Why it works:** Output tokens are 5x more expensive than input tokens. Capping thinking is the single highest-ROI change.

---

## Strategy 8: Decision Log

**Impact: Medium | Effort: Low**

Document why things are the way they are. Prevents Claude from "fixing" intentional patterns or suggesting migrations you've already considered and rejected.

```markdown
## Key Decisions
- REST not GraphQL → team familiarity, CRUD-heavy app
- Prisma not raw SQL → type safety worth the overhead
```

**Why it works:** Without this, Claude might spend tokens suggesting a GraphQL migration or questioning your ORM choice.

---

## Strategy 9: Directory-Level CLAUDE.md

**Impact: Medium | Effort: Medium**

Put small CLAUDE.md files in major directories. They lazy-load only when Claude reads files in that directory.

```
src/api/CLAUDE.md      → "Routes follow RESTful conventions..."
src/database/CLAUDE.md → "Never edit existing migrations..."
```

**Why it works:** Deep context available exactly when needed, invisible when not.

---

## Strategy 10: Request/Data Flow Diagrams

**Impact: Medium | Effort: Low**

ASCII flow diagrams show Claude how components connect, so it knows what to touch for any change.

```
User → React → Redux → API → Controller → Service → DB
```

**Why it works:** Claude understands the full request path in 1 line instead of reading 10 files to reconstruct it.

---

## Strategy 11: Model Selection

**Impact: Very High | Effort: Low**

- Use **Sonnet** for 80% of work (1/5 cost of Opus)
- Use **Opus** only for complex architecture/debugging
- Use **Haiku** for subagents doing simple tasks

**Why it works:** Token costs are directly proportional to model tier. Most coding tasks don't need Opus-level reasoning.

---

## Strategy 12: Smart Compaction

**Impact: High | Effort: Low**

Use `/compact` with instructions: `/compact Focus on the auth module changes only`

This tells the compaction what to preserve, keeping relevant context while dropping irrelevant history.

**Why it works:** Default compaction may drop details you need. Guided compaction keeps what matters.

---

## Strategy 13: One Task Per Session

**Impact: High | Effort: Low**

Start a new session (`/clear`) for each distinct task. Don't fix a bug, then add a feature, then refactor — all in one session.

**Why it works:** Stale context from previous tasks wastes tokens on every subsequent message. A clean session has minimal context overhead.

---

## Strategy 14: Specific Prompts

**Impact: Very High | Effort: Low**

"Add input validation to the login function in src/api/auth.ts" vs "improve the codebase"

The specific prompt needs 3 tool calls. The vague prompt needs 20+.

**Why it works:** Every eliminated exploration step saves hundreds to thousands of tokens.

---

## Combining Strategies

For maximum effect, combine:

| Layer | Strategies | Token Impact |
|-------|-----------|-------------|
| Config | Cap thinking + model selection | -50% |
| Project | Lean CLAUDE.md + .claudeignore | -30% |
| Rules | Path-scoped + directory CLAUDE.md | -20% |
| Skills | Forked exploration + smart-edit | -25% |
| Habits | Specific prompts + one task per session | -30% |

Combined savings can reach **50-70%** compared to an un-optimized setup.

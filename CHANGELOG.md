# Changelog

## [2.3.0] - 2026-03-24

### Features
- **Auto-setup hook** — generates `CLAUDE.md` and `.claudeignore` automatically on first session start. Zero manual steps.
- Detects stack (Node.js, Python, Go, Rust, Ruby), framework, entry points, and commands
- `/setup` skill for deeper project analysis on demand

## [2.2.0] - 2026-03-24

### Features
- **Global `settings.json` auto-install** — hooks fire in every repo automatically
- `/setup` skill for per-project configuration
- Updated CLI output with clear next steps

## [2.1.0] - 2026-03-24

### Features
- **4 new hooks** (total: 8): `block-dangerous.sh`, `auto-format.sh`, `commit-reminder.sh`, `resume-plan.sh`
- **Token optimization rule** with thinking token cap, model selection strategy, smart compaction, subagent strategy, duplicate read prevention
- `MAX_THINKING_TOKENS=10000` set in default settings
- Updated `generate-context.sh` to detect active plans
- Updated `filter-test-output.sh` to also filter build/lint output

## [2.0.2] - 2026-03-24

### Features
- `smart-edit` now auto-invokes to enforce pattern-matching before edits
- All rules now reference relevant skills ("Skills to Use" sections)
- `CLAUDE.md` template includes developer workflow guide

## [2.0.1] - 2026-03-24

### Features
- `gen-context` now auto-invokes for session start context

## [2.0.0] - 2026-03-24

### Features
- **17 new skills** (total: 22): `planning`, `commit`, `review`, `create-pr`, `fix-issue`, `tdd`, `debug-error`, `refactor`, `document`, `security-scan`, `perf-check`, `dep-check`, `changelog`, `migrate`, `onboard`, `plan`, `optimize-tokens`, `setup`
- Complete developer workflow coverage: plan → implement → test → review → commit → PR

## [1.0.4] - 2026-03-23

### Features
- README rewritten with proper GitHub markdown tables
- All sections use left-aligned headers with colon syntax

## [1.0.3] - 2026-03-23

### Features
- **Auto-install via `postinstall`** — `npm i -g` runs setup automatically
- Detailed skill descriptions with examples and invocation guides
- Rules and hooks explained with activation triggers

## [1.0.2] - 2026-03-23

### Features
- npm badges and package link in README
- `npm i -g` install method
- GitHub releases include install commands and npm link
- Workflow syncs version from git tag before publishing

## [1.0.1] - 2026-03-23

### Fixes
- Publish workflow triggers on both `v*` and semver tags

## [1.0.0] - 2026-03-23

### Initial Release
- 4 skills: `explore-area`, `gen-context`, `smart-edit`, `token-check`
- 4 rules: frontend, backend, database, testing
- 3 hooks: `generate-context.sh`, `protect-files.sh`, `filter-test-output.sh`
- Templates: `CLAUDE.md`, `.claudeignore`
- 4 stack examples: Next.js, Express, FastAPI, Monorepo
- 3 docs: strategies, token guide, hooks reference
- Cross-platform install: npm, curl, PowerShell
- Auto-publish to npm via GitHub Actions

# Contributing to Claude Code Optimizer

Thanks for your interest in contributing! This project is built to help every Claude Code user save tokens and work smarter.

## How to Contribute

### Add a New Skill

1. Create a directory: `templates/.claude/skills/your-skill/`
2. Add `SKILL.md` with proper frontmatter:

```yaml
---
name: your-skill
description: What it does and when to use it
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

Your skill instructions...
```

3. Add credit comment at bottom: `<!-- Skill by Your Name | claude-code-optimizer -->`
4. Update `scripts/install.sh`, `scripts/install.ps1`, and `bin/cli.js` to include your skill
5. Submit a PR

### Add a Stack Example

1. Create `examples/your-stack/CLAUDE.md`
2. Fill it with real-world conventions for that framework
3. Submit a PR

### Add a Hook

1. Create `templates/.claude/hooks/your-hook.sh`
2. Add header comment explaining trigger and purpose
3. Wire it in `templates/.claude/settings.json`
4. Update installers
5. Submit a PR

### Add a Rule

1. Create `templates/.claude/rules/your-rule.md`
2. Add `paths:` frontmatter for scoping
3. Reference relevant skills in a "Skills to Use" section
4. Update installers
5. Submit a PR

### Fix a Bug or Improve Existing Code

1. Fork the repo
2. Create a branch: `git checkout -b fix/description`
3. Make your changes
4. Test locally: `npm i -g .` then run `cco`
5. Submit a PR

## Guidelines

- **Keep skills actionable** — step-by-step instructions Claude can follow
- **Keep rules under 50 lines** — shorter = better adherence
- **Path-scope rules** — don't load frontend rules for backend work
- **Use `context: fork`** for read-only exploration skills
- **Use `disable-model-invocation: true`** for skills with side effects
- **Test on Windows + Mac** — hooks must work in bash on both

## Naming Conventions

- Skills: lowercase, hyphens (`fix-issue`, `smart-edit`)
- Rules: lowercase, hyphens (`token-optimization.md`)
- Hooks: lowercase, hyphens (`auto-setup.sh`)

## Commit Messages

Follow conventional commits:

```
feat: add new skill for X
fix: correct hook path on Windows
docs: update README with new skill
```

## Questions?

Open an issue or start a discussion on GitHub.

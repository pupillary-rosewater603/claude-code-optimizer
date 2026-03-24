#!/bin/bash
# auto-setup.sh
# Auto-generates CLAUDE.md and .claudeignore when missing
# Runs on SessionStart — fully automatic, no manual steps
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer

# Skip if CLAUDE.md already exists or setup was already done
if [ -f "CLAUDE.md" ] || [ -f ".claude/CLAUDE.md" ] || [ -f ".claude/.auto-setup-done" ]; then
    exit 0
fi

# Skip if not a project root (no package.json, pyproject.toml, go.mod, Cargo.toml, Gemfile, etc.)
HAS_PROJECT=false
for f in package.json pyproject.toml requirements.txt go.mod Cargo.toml Gemfile pom.xml build.gradle composer.json turbo.json Makefile; do
    if [ -f "$f" ]; then
        HAS_PROJECT=true
        break
    fi
done

if [ "$HAS_PROJECT" = false ]; then
    exit 0
fi

# ── Detect stack ──
STACK=""
BUILD_CMD=""
TEST_CMD=""
LINT_CMD=""
DEV_CMD=""
FRAMEWORK=""

if [ -f "package.json" ]; then
    STACK="Node.js"
    # Extract scripts using node (portable, handles edge cases)
    if command -v node &>/dev/null; then
        BUILD_CMD=$(node -e "try{const p=require('./package.json');console.log(p.scripts?.build||'')}catch(e){}" 2>/dev/null)
        TEST_CMD=$(node -e "try{const p=require('./package.json');console.log(p.scripts?.test||'')}catch(e){}" 2>/dev/null)
        LINT_CMD=$(node -e "try{const p=require('./package.json');console.log(p.scripts?.lint||'')}catch(e){}" 2>/dev/null)
        DEV_CMD=$(node -e "try{const p=require('./package.json');console.log(p.scripts?.dev||'')}catch(e){}" 2>/dev/null)
        # Detect framework from dependencies (not from anywhere in the file)
        FRAMEWORK=$(node -e "try{const p=require('./package.json');const d={...p.dependencies,...p.devDependencies};if(d.next)console.log('Next.js');else if(d.express)console.log('Express');else if(d.fastify)console.log('Fastify');else if(d['@angular/core'])console.log('Angular');else if(d.vue)console.log('Vue');else if(d.svelte||d['@sveltejs/kit'])console.log('SvelteKit');else if(d.react)console.log('React');else console.log('')}catch(e){}" 2>/dev/null)
    fi
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    STACK="Python"
    TEST_CMD="pytest"
    LINT_CMD="ruff check ."
    if [ -f "pyproject.toml" ]; then
        if grep -q "fastapi" pyproject.toml 2>/dev/null; then FRAMEWORK="FastAPI"; DEV_CMD="uvicorn app.main:app --reload"; fi
        if grep -q "django" pyproject.toml 2>/dev/null; then FRAMEWORK="Django"; DEV_CMD="python manage.py runserver"; fi
        if grep -q "flask" pyproject.toml 2>/dev/null; then FRAMEWORK="Flask"; DEV_CMD="flask run"; fi
    fi
elif [ -f "go.mod" ]; then
    STACK="Go"
    BUILD_CMD="go build ./..."
    TEST_CMD="go test ./..."
elif [ -f "Cargo.toml" ]; then
    STACK="Rust"
    BUILD_CMD="cargo build"
    TEST_CMD="cargo test"
elif [ -f "Gemfile" ]; then
    STACK="Ruby"
    if grep -q "rails" Gemfile 2>/dev/null; then FRAMEWORK="Rails"; DEV_CMD="bin/rails server"; TEST_CMD="bin/rails test"; fi
fi

# ── Detect entry points ──
ENTRIES=""
for f in src/app.ts src/app.js src/index.ts src/index.js src/main.ts src/main.js app/layout.tsx app/page.tsx src/server.ts src/server.js app/main.py main.py main.go cmd/main.go src/main.rs src/lib.rs; do
    if [ -f "$f" ]; then
        ENTRIES="$ENTRIES\n- $f"
    fi
done

for f in src/routes/index.ts src/routes/index.js src/api/router.py app/api/router.py; do
    if [ -f "$f" ]; then
        ENTRIES="$ENTRIES\n- $f → routes registered here"
    fi
done

# ── Get project name ──
PROJECT_NAME=$(basename "$(pwd)")

# ── Generate CLAUDE.md ──
cat > CLAUDE.md << CLAUDEEOF
# Project: $PROJECT_NAME

## Commands
- Build: \`${BUILD_CMD:-[fill in]}\`
- Test: \`${TEST_CMD:-[fill in]}\`
- Lint: \`${LINT_CMD:-[fill in]}\`
- Dev: \`${DEV_CMD:-[fill in]}\`

## Stack
${STACK}${FRAMEWORK:+ / $FRAMEWORK}

## Entry Points
$(echo -e "$ENTRIES" | grep -v '^$' || echo "- [fill in your entry points]")

## Key Decisions
- [fill in: Why X not Y → reason]

## Things That Look Wrong But Aren't
- [fill in: file/pattern → why it's intentional]

## Conventions
- [fill in your naming convention]
- [fill in your file organization rule]

## Workflow
- New feature → /plan first, then /smart-edit to implement
- Bug fix → /debug-error or /fix-issue [number]
- Before editing unfamiliar code → /explore-area [dir]
- After all changes → /review then /commit
- Ready to merge → /create-pr
- New developer → /onboard
CLAUDEEOF

# ── Generate .claudeignore ──
if [ ! -f ".claudeignore" ]; then
    cat > .claudeignore << 'IGNOREEOF'
# Dependencies
node_modules/
vendor/
.venv/
__pycache__/
*.pyc

# Build output
dist/
build/
out/
.next/
.nuxt/
target/

# Lock files
package-lock.json
yarn.lock
pnpm-lock.yaml
Pipfile.lock
poetry.lock
Cargo.lock

# Generated/minified
*.min.js
*.min.css
*.bundle.js
*.map

# Binary assets
*.png
*.jpg
*.jpeg
*.gif
*.ico
*.svg
*.woff
*.woff2
*.ttf
*.mp4
*.mp3
*.pdf

# IDE/OS
.idea/
.vscode/
*.swp
.DS_Store
Thumbs.db

# Secrets
.env
.env.*
*.pem
*.key
credentials.json

# Logs & coverage
*.log
logs/
coverage/
.nyc_output/
IGNOREEOF
fi

# ── Mark setup as done (prevents re-running if user deletes CLAUDE.md intentionally) ──
mkdir -p .claude
touch .claude/.auto-setup-done

# ── Output to Claude's context ──
echo ""
echo "## Auto-Setup Complete"
echo ""
echo "Generated CLAUDE.md and .claudeignore for **$PROJECT_NAME** ($STACK${FRAMEWORK:+ / $FRAMEWORK})"
echo ""
echo "CLAUDE.md has [fill in] sections — update them with project-specific details."
echo "Run /setup for a more detailed analysis, or edit CLAUDE.md directly."
echo ""

exit 0

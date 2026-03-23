# Project: Monorepo
<!-- Example by Huzefa Nalkheda Wala | claude-code-optimizer -->

## Commands
- Install: `pnpm install` (from root)
- Build all: `pnpm build`
- Test all: `pnpm test`
- Dev frontend: `pnpm --filter @app/web dev`
- Dev backend: `pnpm --filter @app/api dev`
- Dev specific: `pnpm --filter [package-name] dev`

## Structure
- apps/web/          → Next.js frontend (@app/web)
- apps/api/          → Express backend (@app/api)
- apps/admin/        → Admin dashboard (@app/admin)
- packages/ui/       → Shared React components (@app/ui)
- packages/db/       → Database client + schema (@app/db)
- packages/config/   → Shared tsconfig, eslint (@app/config)
- packages/types/    → Shared TypeScript types (@app/types)

## Entry Points
- apps/web/app/layout.tsx     → Frontend root
- apps/api/src/app.ts         → Backend root
- packages/ui/src/index.ts    → Component exports
- packages/db/src/index.ts    → Database client export
- turbo.json                  → Build pipeline definition

## Key Decisions
- Turborepo for builds → caching, parallel execution
- pnpm workspaces → strict dependency management
- Shared packages/ → single source of truth for types, UI, db
- Each app deploys independently → different Dockerfiles

## Things That Look Wrong But Aren't
- packages/db/ has its own prisma schema → shared across apps
- apps/admin uses different auth → intentional, admin uses RBAC
- Some packages have empty src/index.ts → re-exports from submodules

## Conventions
- New shared code → packages/[name]/
- New app → apps/[name]/
- Cross-app imports only through packages/, never direct app→app
- Each package has its own package.json with @app/ scope

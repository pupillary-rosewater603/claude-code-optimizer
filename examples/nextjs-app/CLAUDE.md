# Project: My Next.js App
<!-- Example by Huzefa Nalkheda Wala | claude-code-optimizer -->

## Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## Entry Points
- app/layout.tsx         → Root layout, providers, global styles
- app/page.tsx           → Home page
- lib/db.ts              → Database connection (Prisma)
- lib/auth.ts            → NextAuth configuration
- middleware.ts           → Auth middleware, redirects

## Request Flow
Browser → Next.js Middleware → Route Handler / Server Component → Prisma → PostgreSQL

## Data Flow
PostgreSQL → Prisma → Server Components → Client Components (via props)
Client mutations → Server Actions → Prisma → PostgreSQL

## Key Decisions
- App Router (not Pages) → better streaming, server components
- Server Actions for mutations → simpler than API routes
- Prisma not Drizzle → team familiarity, better docs
- Tailwind CSS → consistent styling, no CSS-in-JS runtime

## Things That Look Wrong But Aren't
- No /api/ routes for most CRUD → using Server Actions instead
- Some components have "use client" at top → needed for interactivity
- lib/utils.ts has a cn() function → shadcn/ui pattern for className merging

## Conventions
- Components in app/ are page-level, reusable ones in components/
- All database queries go through lib/db/ service files
- Form validation with zod schemas in lib/validations/
- Search `@claude-entry` for wiring points

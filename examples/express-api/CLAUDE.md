# Project: Express REST API
<!-- Example by Huzefa Nalkheda Wala | claude-code-optimizer -->

## Commands
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test`
- Migrate: `npx prisma migrate dev`
- Seed: `npm run seed`

## Entry Points
- src/app.ts             → Express app, middleware stack
- src/routes/index.ts    → All routes registered here (@claude-entry)
- src/config/index.ts    → Environment variables, config
- prisma/schema.prisma   → Database schema

## Request Flow
Client → Express → CORS/Helmet → Auth Middleware → Route → Controller → Service → Prisma → PostgreSQL

## Error Flow
Error thrown → errorHandler middleware → { error: string, code: string, status: number }

## Key Decisions
- Express not Fastify → team knows Express, performance is fine for our scale
- Prisma not TypeORM → better DX, type inference
- JWT in httpOnly cookies → more secure than localStorage
- No GraphQL → REST is simpler for our CRUD-heavy API

## Things That Look Wrong But Aren't
- src/middleware/auth.ts is duplicated in tests/ → test version uses mock JWT
- Some routes have no auth middleware → intentionally public endpoints
- prisma/seed.ts imports from src/ → shares model types, runs separately

## Conventions
- One file per resource in routes/, controllers/, services/
- Zod schemas for request validation in src/validations/
- Tests colocated: src/routes/users.test.ts
- Error codes are UPPER_SNAKE: USER_NOT_FOUND, INVALID_TOKEN

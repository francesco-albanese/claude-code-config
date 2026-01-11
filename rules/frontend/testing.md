---
paths: ["**/*.test.tsx", "**/*.test.ts", "**/*.spec.ts", "**/playwright/**"]
---

# Testing Strategy

## Unit/Integration Tests
- Use Vitest as test runner
- React Testing Library for component tests https://www.npmjs.com/package/@testing-library/react
- Focus on user behavior, not implementation details
- Test real use cases, not coverage metrics

## E2E Tests
- Playwright with playwright-bdd
- Use Cucumber/Gherkin syntax
- Mimic real user workflows
- Tests MUST pass before commit

## Test Quality
- Write meaningful scenarios
- Test actual user journeys
- Identify real failure points
- Never write tests just for coverage

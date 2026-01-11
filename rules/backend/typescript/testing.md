---
paths: ["**/*.test.ts", "**/*.spec.ts"]
---

# Testing Strategy

## Unit/Integration Tests
- Vitest as test runner
- Test business logic and API contracts
- Mock AWS services with aws-sdk-client-mock
- Focus on real failure scenarios

## Test Quality
- Test actual use cases of the application
- Do not write tests just for the sake of increasing coverage
- Write tests that mimic how real users would use the application
- Validate error handling
- Tests MUST pass before deploy

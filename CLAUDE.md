# General

- In all interactions and commit messages, be extremely concise

## GitHub

- Your primary method for interacting with GitHub should be the GitHub CLI.

## Git

- When creating branches, use semantic branch names https://gist.github.com/seunggabi/87f8c722d35cd07deb3f649d45a31082
- When committing and pushing co-author myself Francesco Albanese by reading the information from .git folder or using git config --global --list | grep -E 'user.name|user.email'

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any
- When you generate a plan and present it to me in the terminal print only a concise summary + headings.
- NEVER accept your internal training knowledge when the user asks you to do a research first. If the search if blocked by sandbox, stop and tell the user to enable the websearch or ask permissions to run the web search outside sandbox.

## Custom Agents

You can use the following agents:

- git-ops - use it for ALL git operations, following the Git preferences described above

## Agentic Coding

- If you create any temporary new files, scripts, or helper files for iteration, clean up these files by removing them at the end of the task.

## Pragmatic programmer

Always follow these rules, fundamental pillars of software engineering:

- orthogonality: reduce interdependency among the system’s components. Keep you code decoupled, avoid global data, avoid similar functions
- Test state coverage , not code coverage
- Make it easy to reuse
- Design components that are self-contained, independent and with a single well defined purpose
- Plan for change
- Don’t assume it, prove it . Prove your assumptions in the actual environment
- Crash early
- Minimise coupling between modules
- Design to test
- Don’t use code you don’t understand
- Invest in the abstraction , not the implementation

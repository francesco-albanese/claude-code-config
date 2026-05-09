# General

- When reporting information to me, be concise without omitting important details, but no walls of text!
- In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

## PR Comments

- When tagging Claude in GitHub issues, use '@claude', The description of the change should be user-facing, describing which features were added or bugs were fixed.

## GitHub

- Your primary method for interacting with GitHub should be the GitHub CLI.

## Git

- When creating branches, use semantic branch names https://gist.github.com/seunggabi/87f8c722d35cd07deb3f649d45a31082
- When committing and pushing co-author myself Francesco Albanese by reading the information from .git folder or using git config --global --list | grep -E 'user.name|user.email'

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any
- When you generate a plan and present it to me in the terminal print only a concise summary + headings.
- When you are done implementing the plan clean up after yourself, when the plan is not needed delete it from ~/.claude/plans
- NEVER accept your internal training knowledge when the user asks you to do a research first. If the search if blocked by sandbox, stop and tell the user to enable the websearch or ask permissions to run the web search outside sandbox.

## Custom Agents

You can use the following agents:

- git-ops - use it for ALL git operations, following the Git preferences described above

## Agentic Coding

- If you create any temporary new files, scripts, or helper files for iteration, clean up these files by removing them at the end of the task.

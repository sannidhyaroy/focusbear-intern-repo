# CI/CD Reflection

## What is the Purpose of CI/CD?

**Continuous Integration (CI)** is the practice of automatically building and testing code every time a change is pushed to a shared repository. The goal is to catch integration problems early before they compound into larger issues by ensuring that every change is verified against the full test suite and quality checks before it can be merged.

**Continuous Deployment (CD)** extends CI by automatically deploying verified changes to production or staging environments. Together, CI/CD replaces the "merge and pray" approach with a structured pipeline that enforces quality gates at every step.

CI/CD is not just automation, it is a shift in where quality is enforced. Without CI/CD, quality depends on individual discipline. With CI/CD, quality is enforced structurally, so a PR that breaks tests or fails linting cannot be merged regardless of who authored it or how urgent the change feels.

## Setting Up the CI Workflow

A GitHub Actions workflow was added to this repo to run Markdown linting and spell checks automatically on every push and pull request targeting `main`. Branches prefixed with `ci/` also trigger the workflow, which allows testing workflow changes in isolation before merging, solving the chicken-and-egg problem where CI configuration changes normally can't be validated by the CI they configure.

The full workflow is committed to [`.github/workflows/markdown-quality.yml`](https://github.com/sannidhyaroy/focusbear-intern-repo/blob/main/.github/workflows/markdown-quality.yml).

Key design decisions:

- `dorny/paths-filter` ensures the linter only runs when markdown files are actually changed, so no unnecessary job runs on unrelated commits
- Auto-fix is enabled: formatting issues are corrected and committed back to the PR branch automatically, so the author doesn't have to fix and re-push manually
- The commit-back step is guarded to only run on PRs, not on direct pushes

## Git Hooks

Git hooks are scripts that Git runs automatically at specific points in the workflow, like before a commit, before a push, after a merge, and so on. They are the last line of defense before code leaves the local machine.

Tools like Husky, Lefthook, and pre-commit exist to make hooks manageable in team codebases, storing configuration in the repository so every developer gets the same hooks without manual setup. I knew this going in, but I still wanted to do the native approach because this project has zero dependencies and no package manager.

### The Native Approach

A plain shell script in `.githooks/pre-commit`, activated with `git config core.hooksPath .githooks`, requires zero dependencies. One setup command, fully auditable, no package manager involved. It felt clean.

Then I imagined a problem in my mind after staring at the shell script for some time. I use `git add -p` regularly to stage changes selectively, committing only specific hunks rather than entire files to ensure commits are scoped appropriately. The hook runs after staging but before the commit, and when it auto-fixes a file and re-stages it with `git add`, it pulls in everything, including the hunks I had deliberately left unstaged. My careful partial staging would be silently overwritten, if I committed to this approach.

I could not find a clean fix for this within the native approach, without the deep rabbit hole of extremely complex shell code. The hook has no awareness of what was and was not intentionally staged. I thought that I could make the hook stash the unstaged files, then apply the fix, stage them, and then unstash the files again, but then I thought to not further complicate things and hit a roadblock again, so I ditched this approach. After all, that is exactly the kind of edge case these tools were built to handle, and experiencing it firsthand made that value concrete in a way no documentation ever could.

### Switching to Lefthook

[Lefthook](https://lefthook.dev) is a language-agnostic Git hook manager written in Go, making it significantly faster and ideal for mixed-stack or monorepo projects. Unlike [Husky](https://typicode.github.io/husky), which is a JavaScript-centric tool that ties directly into the Node/npm ecosystem and itself only orchestrates when a hook triggers (it doesn't actually filter files, which leads users to configure [lint-staged](https://github.com/lint-staged/lint-staged) alongside), Lefthook is a centralized config solution with parallel execution. The lefthook configuration in this repo is in [`lefthook.yml`](https://github.com/sannidhyaroy/focusbear-intern-repo/blob/main/lefthook.yml). The key feature is `stage_fixed: true`, so it re-stages only the files modified by the auto-fix, leaving the rest of the staging area untouched. My `git add -p` workflow would be preserved.

The `skip` conditions handle merge and rebase contexts where linting would be disruptive, and bail gracefully if `npx` is unavailable. Setup after cloning is one command: `lefthook install`, and if a project uses a package manager, that would make it even simpler by pulling lefthook as a dependency automatically.

Even though I ditched the native shell script in the repo, I kept the documentation honest about the attempt, so both approaches are visible, and the reason for the switch is documented. The shell script is not wrong, it just has a limitation that matters for how I work.

|                                **Native shell script**                                |                                  **Lefthook**                                  |
| :-----------------------------------------------------------------------------------: | :----------------------------------------------------------------------------: |
|  ![Native hooks](../../assets/images/Screenshot%202026-05-28%20at%204.55.42 PM.png)   | ![Lefthook](../../assets/images/Screenshot%202026-05-28%20at%206.54.26 PM.png) |
| *Zero dependencies, one setup command, complex edge cases should be manually handled* |                   *Lefthook as a pre-commit hook in action*                    |

## How Does Automating Style Checks Improve Project Quality?

Automated checks remove style enforcement from the critical path of code review. Without automation, reviewers spend attention on formatting issues, missing blank lines, inconsistent heading levels, misspelled words, rather than on logic, architecture, and correctness. Automation handles the mechanical checks so humans can focus on the decisions that actually require judgment.

Automation is also consistent in a way humans are not. A linter applies the same rules to every file on every PR without fatigue, distraction, or favoritism. A human reviewer might catch a style issue on Monday morning and miss the same issue on Friday afternoon.

## What Are Some Challenges with Enforcing Checks in CI/CD?

- **False positives:** linters sometimes flag valid content. Technical terms, proper nouns, and domain-specific vocabulary trigger spell checkers. Managing a custom dictionary or ignore list requires ongoing maintenance.
- **Slow pipelines:** checks that take too long create friction and encourage developers to skip or work around them. Fast feedback loops are essential for CI to be useful rather than annoying.
- **Configuration drift:** CI configuration can become inconsistent with local development configuration, producing checks that pass locally but fail in CI. Using the same tool versions and configurations in both contexts prevents this.
- **Over-enforcement:** enforcing too many rules too strictly can slow down legitimate work. The goal is to catch real problems, not to create busywork.

## How Do CI/CD Pipelines Differ Between Small Projects and Large Teams?

In a small project or solo repository, CI is primarily a safety net, it catches mistakes before they merge and provides a record of what was verified. The pipeline is simple: lint, test, maybe deploy. Speed matters more than comprehensiveness.

In large teams, CI becomes a coordination mechanism. Multiple developers pushing to many branches simultaneously means the pipeline must handle parallelism, flaky tests, dependency caching, and staged rollout. CD in large teams typically involves canary deployments, feature flags, and rollback mechanisms that do not exist in small projects.

This repo pipeline is appropriately minimal. A production macOS app like Focus Bear would likely have a significantly more complex pipeline: Swift compilation, XCTest suite, UI tests, code signing, notarization, and staged distribution via Sparkle.

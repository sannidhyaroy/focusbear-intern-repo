# Git Concepts: Staging vs Committing

## What is the Difference Between Staging and Committing?

Git has a three-stage model: the working directory, the staging area (also called the index), and the repository.

The **working directory** is where you make changes to files. These changes are untracked by Git until you explicitly tell it to care about them.

**Staging** (`git add`) is the act of telling Git "I want to include this change in my next commit." It moves changes from the working directory into the staging area. The staging area is a snapshot of what your next commit will look like.

**Committing** (`git commit`) takes everything in the staging area and permanently records it in the repository's history as a new commit. A commit is immutable (commit amends/rebasing changes the commit itself, thereby it's commit hash too). Once made, it is part of the project's history.

In short: staging selects what to include, committing records it permanently.

## Why Does Git Separate These Two Steps?

The separation gives you precise control over what goes into each commit. Without a staging area, every change in your working directory would be committed together, making it impossible to group related changes into meaningful, atomic commits.

With staging, users can:
- Work on multiple things simultaneously and commit them separately
- Partially stage a file (using `git add -p`) to commit only specific changes within a file
- Review exactly what will be committed before committing it

This is especially useful when you have been working for a while and accumulated changes across multiple files. Staging lets you reconstruct a clean, logical commit history even from a messy working state.

## When Would You Want to Stage Without Committing?

The most honest answer is that staging is not just a gateway to committing, it is a revision tool. My own workflow treats staging as an incremental review pass before a commit is finalized. When working on a feature, I build it in whatever order makes sense developmentally, then stage changes in deliberate segments to construct a commit that tells a coherent story, not just a snapshot of wherever I happened to stop.

This matters because commit history is permanent. Everyone thinks incrementally when building something, but that incremental thinking does not need to be preserved verbatim in the history. A commit that arrived through ten messy intermediate states should still read cleanly. Staging makes that possible without requiring you to slow down while working.

Some specific scenarios where staging without committing is useful:

- **Grouping related changes:** You changed several files but not all are related. Stage the related ones and commit them together, handle the rest in a separate commit.
- **Reviewing before committing:** Stage changes and run `git diff --staged` to inspect exactly what will be committed, catching mistakes or unintended changes before they enter history.
- **Partial file staging:** Use `git add -p` to stage specific hunks within a file, leaving other in-progress changes unstaged for a later commit. Useful when a file contains both a complete change and an incomplete one.
- **Constructing clean commits from messy work:** Stage changes in a logical order to produce commits that make sense to a future reader, even if the actual development order was non-linear.

Related tools that extend this workflow:

- **`git commit --fixup` and `git rebase --autosquash`**: create fixup commits that automatically get squashed into their target commit during an interactive rebase, keeping the history clean without manual squash editing.
- **`git commit --amend`**: fold staged changes into the previous commit, useful for small corrections that do not deserve their own commit.
- **Interactive rebase (`git rebase -i`)**: reorder, squash, edit, or drop commits before they are pushed, allowing the history to be refined after the fact.

The underlying philosophy is that a commit is not just a save point, it is a unit of communication. Staging is what gives you the control to make each commit say exactly what it should.

## Practical Task

![TASK#42](../../assets/onboarding/Screenshot%202026-05-22%20at%209.16.46 AM.png)

# Branching & Team Collaboration

## Why is Pushing Directly to Main Problematic?

`main` (or `master`) represents the canonical, stable state of the project. Pushing directly to it means every change, finished or not, reviewed or not, immediately becomes part of that canonical state. In a team context this is problematic for several reasons:

- There is no review gate. Broken code, unfinished features, or accidental changes go straight into the shared baseline that everyone else is working from.
- It makes it harder to revert. If something goes wrong, unpicking a direct push from `main` is messier than simply closing a PR or deleting a branch.
- It creates race conditions. Two people pushing to `main` simultaneously can overwrite each other's work or create a chaotic merge situation with no clear resolution path.
- CI/CD pipelines typically trigger on `main`. A bad direct push can break deployments or trigger incorrect releases.

Even on solo projects, pushing directly to `main` is a habit worth avoiding. Future collaborators, or future you, will thank you for it.

## How Do Branches Help with Reviewing Code?

Branches isolate work. When a change lives on a branch, it can be reviewed, tested, and discussed independently before it affects anyone else. A pull request against `main` (or `master`) creates a structured opportunity to:

- Read the diff in context before it merges
- Run automated checks (tests, linters, CI) against the change in isolation
- Leave inline comments on specific lines
- Request changes or approve

This is fundamentally different from reviewing code after it has already been merged. Pre-merge review catches problems while they are still cheap to fix.

**NOTE:** _This describes the pull request/merge request model common on platforms like GitHub and GitLab. Other workflows exist, like Gerrit reviews individual commits rather than branches, and git's original workflow uses emailed patches via `git format-patch` and `git am` (the kernel still works this way). The branch/PR model is dominant in modern team workflows, but is not the only valid approach._

## What Happens if Two People Edit the Same File on Different Branches?

Git handles this through merging. If the edits are in different parts of the file, Git can often merge them automatically. If the edits overlap, i.e, both people changed the same lines, git produces a merge conflict and requires a human to resolve it.

Conflicts are not a failure of git. These are git correctly identifying that two independent changes cannot be automatically reconciled and need human judgment. The branch model makes conflicts manageable by isolating them to the merge point rather than letting them accumulate silently in a shared working state.

The alternative, where everyone working directly on `main` does not eliminate conflicts, it just makes them harder to detect and resolve because there is no clear boundary between whose change is whose.

## Practical Task

![TASK#43](../../assets/onboarding/Screenshot%202026-05-22%20at%2010.21.21 AM.png)

# Writing Meaningful Commit Messages

## What Makes a Good Commit Message?

The most widely adopted convention for commit messages is the [Conventional Commits](https://www.conventionalcommits.org) specification, which structures messages as:

<pre>
<b>&lt;type&gt;</b>(<b>&lt;optional scope&gt;</b>)<b>&lt;!&gt;</b>: <b>&lt;short description&gt;</b>
<sub>empty line as separator</sub>
<b>&lt;optional body&gt;</b>
<sub>empty line as separator</sub>
<b>&lt;optional footer&gt;</b>
</pre>

The `!` is optional and denotes a breaking change, i.e, a change that is incompatible with the previous version and requires consumers to update their code. For example: `feat(api)!: remove deprecated /v1/users endpoint`. Breaking changes can also be documented in the footer using `BREAKING CHANGE: <description>`, or both.

Common types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `ci`.

A good commit message:
- Has a subject line under 72 characters
- Uses the imperative mood ("add feature" not "added feature")
- Clearly states what changed and why, not how
- Is scoped to a single logical change
- Would make sense to someone reading the history six months later with no other context

A commit message is not a description of what you did while writing the code. It is a description of what the codebase now does that it did not before.

## How Does a Clear Commit Message Help in Team Collaboration?

Commit history is the project's changelog, audit trail, and debugging tool all at once. Clear commit messages make several things significantly easier:

- **CI/CD automation:** Many pipelines parse commit messages to determine release behavior. Conventional Commits (or any consistent convention) allows tools like `semantic-release` to automatically determine version bumps (major/minor/patch), generate changelogs, and trigger deployments based on commit type. A `feat:` commit bumps a minor version, a `fix:` bumps a patch, a `feat!:` or `BREAKING CHANGE:` bumps a major. This only works if commit messages are structured and consistent.
- **Bisecting:** `git bisect` works by checking out commits and testing them. If commit messages are meaningful, you can often find the culprit just by reading the log without running the code.
- **Blame:** `git blame` shows who changed each line and in which commit. A meaningful commit message tells you *why* that line exists, which is often more valuable than knowing who wrote it.
- **Reverting:** If a commit needs to be reverted, a clear message tells you immediately what the impact of reverting will be, without having to read the diff.
- **Code review:** A well-scoped commit with a clear message makes the reviewer's job easier, since they know what to look for and what the intent is (since you are reading this, yes, this commit is doing exactly that for you).
- **Onboarding:** New team members can understand the evolution of the codebase by reading the history, but only if the history is readable.

## How Can Poor Commit Messages Cause Issues Later?

Poor commit messages like "fixed stuff", "wip", "changes", "update", etc. are essentially noise in the history. They force anyone debugging or auditing to read the full diff of every commit to understand what changed and why, which is exactly the work that a good commit message should eliminate.

More specifically:
- **CI/CD pipelines break down:** If your pipeline relies on commit message conventions to determine versioning or trigger specific workflows, vague messages like "fixed stuff" either cause the pipeline to make wrong decisions or fall back to defaults, potentially shipping a patch version when a breaking change was introduced, or failing to generate accurate release notes entirely.
- **Bisecting becomes guesswork.** Without meaningful messages you cannot narrow down which commit introduced a bug without running each one.
- **Reverting becomes risky.** "fixed stuff" tells you nothing about what reverting will break.
- **Fixup and squash workflows break down.** Tools like `git rebase --autosquash` rely on commit message conventions (`fixup!`, `squash!`) to work correctly. Vague messages make this impossible to use effectively.
- **Accountability is lost.** In a team, you want to be able to understand not just what changed but why it was decided. Poor messages erase that context permanently.

A commit message cannot be retroactively improved once it is in shared history without rewriting history, which is disruptive in a team context. The cost of writing a good message upfront is seconds. The cost of a bad one compounds indefinitely.

## Real-World Example: React's Commit History

| **React Commit History** |
| :----------------------: |
| ![React Commits](../../assets/onboarding/React%20Commits.jpeg) |
| *React's commit history as a reference to analyze good vs bad commit messages* |

React's commit history is a good real-world reference. The Facebook/Meta team uses a `[scope] description` convention rather than Conventional Commits strictly, but the commits are consistent, human-readable, and machine-parseable enough for their tooling.

**Good examples from React's history:**

- `[compiler] Don't emit spurious import { c as _c } for discarded functions`: scoped, specific, explains exactly what changed and why
- `[Fizz] prevent reentrant finishedTask from calling completeAll multiple times` : precise, explains the race condition being fixed
- `fix[describeClassComponentFrame]: invoke constructor with new keyword`: scoped to a specific function, clear imperative action

**Mediocre examples:**

- `Fix FragmentInstance listener leak: normalize boolean vs object capture options per DOM spec`: describes the bug, the fix, and references the standard it aligns with, but doesn't follow React's convention
- `[ephr] Update changelog for 7.1.0`: acceptable but mechanical, carries no information about what changed in 7.1.0

**Bad examples:**
- `Fix formatting`: no scope, no context, could mean anything in any file

### Key takeaway

React doesn't follow Conventional Commits strictly: and that is fine. The important
thing is consistency within a project and clarity for both humans and tooling. A team
that consistently uses `[scope] description` is more readable than one that
inconsistently follows any formal spec. The optimal commit message is one that is
clear, consistently structured, and parseable by both humans and CI/CD pipelines.

## Practical Task

![TASK#46](../../assets/onboarding/Screenshot%202026-05-22%20at%201.24.42 PM.png)


# Merge Conflicts & Conflict Resolution

## What Causes Merge Conflicts?

A merge conflict occurs when Git cannot automatically reconcile differences between two branches. This happens when:

- Two branches have edited the same lines in the same file differently
- One branch has deleted a file that another branch has modified
- Two branches have added different content at the same position in a file

Git is actually quite good at merging automatically. It handles changes in different parts of the same file without conflict. Conflicts only arise when the same region of a file has diverged in incompatible ways, and Git genuinely cannot determine which version to keep without human judgment.

## How Git Marks Conflicts

When a conflict occurs, Git marks the affected file with conflict markers:

```
<<<<<<< HEAD
<content from the current branch>
=======
<content from the branch being merged>
>>>>>>> branch-name
```

Everything between `<<<<<<< HEAD` and `=======` is what the current branch had. Everything between `=======` and `>>>>>>> branch-name` is what the incoming branch had. You resolve the conflict by editing the file to the correct final state and removing the markers entirely.

## How I Reproduced and Resolved the Conflict

![TASK#60](../../assets/onboarding/Screenshot%202026-05-25%20at%2011.18.57 AM.png)

## What I Learned

A few things worth noting beyond the mechanics:

**Conflicts are not failures:** They are Git correctly identifying ambiguity that requires human judgment. The branching model makes conflicts manageable, without branches, the same divergence would happen silently in a shared working directory with no structured resolution path.

**Prevention is better than resolution:** Long-lived branches that diverge significantly from main are the primary source of painful conflicts. Short-lived feature branches that are merged or rebased frequently are much less likely to produce conflicts, and when they do the conflicts are smaller and easier to resolve.

**Rebase vs merge for conflict resolution:** Merging creates a merge commit that preserves the full branch history. Rebasing replays commits from the feature branch on top of main, producing a linear history but rewriting commit hashes. For shared branches, rebase should be used carefully. For local feature branches, rebase before merging keeps the history clean.

**`git rerere` (reuse recorded resolution):** if you resolve the same conflict multiple times (common during long rebases), Git can remember your resolution and apply it automatically in future. Worth knowing exists even if not used daily.

# Creating & Reviewing Pull Requests

## What is a Pull Request and Why is it Used?

A Pull Request (PR) in GitHub (also, called a Merge Request in GitLab) is a request to merge changes from one branch into another, typically from a feature branch into `main`. It is not a Git concept natively, it is a collaboration feature built on top of Git by hosting platforms like GitHub and GitLab.

The PR serves several purposes simultaneously:
- It creates a structured review gate before changes reach the main branch
- It provides a discussion space for the proposed changes
- It triggers CI/CD checks automatically
- It documents why a change was made, not just what changed
- It links code changes to issues, tickets, or conversations

## Why are PRs Important in a Team Workflow?

PRs are the primary mechanism by which teams maintain code quality without slowing down individual contributors. Without PRs, every change goes directly to the shared branch, which means every mistake, every half-finished feature, and every style inconsistency becomes everyone's problem immediately.

With PRs:
- Changes are isolated until they are ready and reviewed
- Reviewers can catch bugs, design issues, and inconsistencies before they reach production
- The PR description and comments become permanent documentation of why a decision was made
- Automated checks (tests, linters, security scans) run against the change before it merges
- Junior contributors get structured feedback rather than silent judgment

PRs also create accountability without micromanagement. A reviewer approving a PR is taking shared responsibility for that change, which encourages thorough review rather than rubber-stamping.

## What Makes a Well-Structured PR?

A well-structured pull request (PR) has:

- **A clear, descriptive title** following the same conventions as commit messages, what changed and why, not a vague "fix stuff"
- **A description** that explains the motivation, the approach taken, and any trade-offs or alternatives considered
- **Links to related issues** so reviewers understand the context without having to search for it
- **Screenshots or recordings** for UI changes so reviewers can see the result without checking out the branch
- **A small, focused scope:** PRs that change one thing are reviewed faster and more thoroughly than PRs that change everything at once
- **Self-review before requesting review:** the author should read their own diff before asking someone else to

### Reviewing an Open-Source PR: React #36253

[`[react-native-renderer] EventTarget-based event dispatching`](https://github.com/facebook/react/pull/36253) is a good real-world reference for what a well-structured PR looks like in a large open-source project.

**What stands out:**

- **Detailed summary:** the PR description explains not just what changed but the architectural reasoning like why EventTarget-based dispatching was chosen, what the cost model is (shifting cost from every render to only when events fire), and what is explicitly out of scope (responder events bypass EventTarget entirely).
- **Inline review comments on specific lines:** reviewers `javache` and `rubennorte` leave comments directly on the affected files, asking concrete questions: "Any changes you want to highlight from the previous implementation?", "Why isn't this using ReactFeatureFlags?". These are not vague, they point to specific design decisions.
- **History and maintainability concerns raised:** the reviewer explicitly asks about preserving source control history for a 1:1 port, which is the kind of long-term thinking that makes codebases maintainable. The author responds with reasoning, not just a fix.
- **Feature flagged:** the change is behind `enableNativeEventTargetEventDispatching`, meaning it can be merged without affecting existing behavior. This is a standard pattern for large changes in production codebases.

## Practical Task

All issues in this milestone have been submitted and merged via PRs on the intern repo, each with a descriptive title, body, and link to the related issue. This document itself will be merged via a PR linked to this issue, a self-referential proof that the task is being completed as intended.

For the full review-approve-merge cycle, [Wayfinder PR #445](https://github.com/OneBusAway/wayfinder/pull/445) is a real example from my open-source contributions, which was submitted to the Wayfinder project, reviewed by the project maintainer, approved, and merged. That is the complete PR lifecycle demonstrated in an actual team context outside of this internship.

# Debugging with `git bisect`

## What Does `git bisect` Do?

`git bisect` is a debugging tool that uses binary search to find which commit introduced a bug. Instead of manually checking commits one by one, Git halves the search space with each step, making it logarithmically faster than linear search.

The workflow:

```bash
git bisect start
git bisect bad                  # current commit has the bug
git bisect good <commit-hash>   # this commit was known to be clean
```

Git then checks out the midpoint commit. You test it and tell Git the result:

```bash
git bisect good   # bug not present here
git bisect bad    # bug present here
```

Git keeps halving the range until it identifies the exact commit that introduced the bug. When done:

```bash
git bisect reset  # return to original HEAD
```

With `git bisect run <script>`, the entire process can be automated. Git runs your test script at each step and uses the exit code to determine good or bad automatically.

## When Would You Use It in a Real-World Debugging Situation?

The classic scenario: a bug exists in the current version that didn't exist in a previous release, but you don't know which of the hundreds of commits between them introduced it. Manual review would take hours. Bisect finds it in `log₂(n)` steps for 1000 commits, that's at most 10 steps.

Specific situations:

- **Regression bugs:** Something worked in v1.2 but is broken in v1.5. You know the good commit (v1.2 tag) and the bad commit (HEAD). Bisect finds the culprit in minutes.
- **Performance regressions:** Combined with a benchmark script and `git bisect run`, you can automatically find which commit caused a slowdown without manual intervention.
- **Flaky test introduction:** If a test started failing intermittently, bisect can find when it was introduced even if reproducing it is probabilistic.
- **Combined with `git blame`:** Blame tells you who changed a line and in which commit. Bisect tells you which commit broke behavior. Together they give the full picture.

## How Does It Compare to Manually Reviewing Commits?

Manual review is `O(n)`, you check commits one by one until you find the problem. For 10 commits this is fine. For 100 it is tedious. For 1000 it is impractical.

Bisect is `O(log n)`, so each step eliminates half the remaining candidates. 1000 commits is 10 steps. 1,000,000 commits is 20 steps.

More importantly, manual review requires you to understand each commit's intent and reason about whether it could have caused the bug. Bisect requires only a reliable way to reproduce the bug, the reasoning is replaced by binary search. This is especially valuable when the bug is subtle or the codebase is unfamiliar.

The limitation of bisect is that it requires a reproducible test condition. If you cannot reliably determine whether a given commit is good or bad, bisect cannot help. It also finds the first bad commit, not necessarily the root cause. The actual bug may have been introduced by a dependency change or an implicit assumption that was violated by a seemingly unrelated commit.

## Practical Task

![TASK#45](../../assets/onboarding/Screenshot%202026-05-26%20at%201.32.32 AM.png)

# Advanced Git Commands & When to Use Them

## `git restore --source=<branch> <file>` (formerly `git checkout <branch> -- <file>`)

**What it does:**
Restores a specific file to its state in another branch or commit without affecting anything else in the working tree or staging area. The modern equivalent of `git checkout main -- <file>` is `git restore --source=main <file>`, which is recommended instead of the checkout subcommand.

**When to use it:**
- You accidentally deleted or corrupted a file and want to restore it from `main` without reverting other in-progress changes
- You want to bring in a specific file from another branch without merging or cherry-picking
- You need to compare your version of a file against another branch's version by temporarily restoring it

**Real-world scenario:**
You are deep in a feature branch and realise you need the latest version of a config file from `main` that was updated by a teammate. Rather than merging or stashing and switching branches, you restore just that file.

```bash
git restore --source=main config/settings.json
# or, the older form:
git checkout main -- config/settings.json
```

---

## `git cherry-pick <commit>`

**What it does:**
Applies the changes introduced by a specific commit onto the current branch, creating a new commit with the same changes but a different hash. It does not merge the entire branch, only the specified commit.

**When to use it:**
- A bug fix was committed to a feature branch and needs to be applied to `main` without merging the entire feature
- A hotfix needs to be applied to multiple release branches simultaneously
- You committed something to the wrong branch and need to move just that commit

**Real-world scenario:**
A critical security fix was committed to `feature/auth-refactor` which is not ready to merge. Cherry-pick the fix commit onto `main` and the `release/2.x` branch independently.

```bash
git cherry-pick 623927a
# Cherry-pick a range of commits
git cherry-pick abc123..def456
```

**Gotcha:** Cherry-picked commits get new hashes. If the original commit is later merged, Git may see the changes as duplicates and produce an empty commit, use `git cherry-pick -x` to add a note referencing the original commit hash, making future merges cleaner.

---

## `git log`

**What it does:**
Displays the commit history. With various flags it becomes one of the most powerful investigation tools in Git.

**Useful flags:**

```bash
# Compact one-line view
git log --oneline

# Visual branch graph
git log --oneline --graph --decorate --all

# Find commits that changed a specific string (pickaxe search)
git log -S "functionName"

# Find commits affecting a specific file, following renames
git log --follow -- path/to/file

# Show commits by a specific author
git log --author="Sannidhya"

# Show commits in a date range
git log --after="2026-01-01" --before="2026-06-01"

# Show what changed in each commit
git log -p

# Show stats (files changed, insertions, deletions)
git log --stat
```

**When to use it:**
- Understanding how a codebase evolved over time
- Finding when a specific function or string was introduced (`-S` pickaxe)
- Investigating who worked on what and when
- Tracing file renames across history (`--follow`)

The pickaxe search (`-S`) is particularly underrated as it finds commits where a specific string was added or removed, which is invaluable for tracking down when a specific piece of logic was introduced or deleted.

---

## `git blame <file>`

**What it does:**
Annotates each line of a file with the commit hash, author, and date of the last modification to that line. It answers "who wrote this line and when", though more importantly, combined with `git log`, it answers "why does this line exist."

**Useful flags:**

```bash
# Blame a specific line range
git blame -L 10,25 path/to/file

# Ignore whitespace changes
git blame -w path/to/file

# Ignore lines moved or copied from other files in the same commit
git blame -C path/to/file

# Show the actual commit content for each blamed line
git blame -p path/to/file
```

**When to use it:**
- A line of code looks wrong or surprising, blame tells you which commit introduced it, then `git show <hash>` tells you the full context of that change
- Understanding why a particular implementation choice was made by finding the commit and reading its message and diff
- Identifying who to ask about a specific piece of code

**Important nuance:** `git blame` shows the last modification, not the original author. If someone reformatted the file, blame will point to the reformatting commit rather than the original logic. Use `-w` to ignore whitespace and `-C` to detect moved code. In practice, blame is a starting point for investigation, not the final answer.

## What Surprised Me While Testing

`git log -S` (pickaxe search) is something I knew about conceptually but testing it concretely made its power more apparent. Being able to search commit history for when a specific string was added or removed, across the entire project history is faster than grep-based approaches for historical investigation.

The `-x` flag on `git cherry-pick` was also a useful reminder. It appends the original commit hash to the cherry-picked commit message, which prevents confusion when the source branch is eventually merged and Git encounters what looks like a duplicate change.

## Practical Task

![TASK#44](../../assets/onboarding/Screenshot%202026-05-26%20at%209.56.58 AM.png)

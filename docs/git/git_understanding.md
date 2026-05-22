# Git Concepts: Staging vs Committing

## What is the Difference Between Staging and Committing?

Git has a three-stage model: the working directory, the staging area (also called
the index), and the repository.

The **working directory** is where you make changes to files. These changes are
untracked by Git until you explicitly tell it to care about them.

**Staging** (`git add`) is the act of telling Git "I want to include this change in
my next commit." It moves changes from the working directory into the staging area.
The staging area is a snapshot of what your next commit will look like.

**Committing** (`git commit`) takes everything in the staging area and permanently
records it in the repository's history as a new commit. A commit is immutable (commit amends/rebasing changes the commit itself, thereby it's commit hash too).
Once made, it is part of the project's history.

In short: staging selects what to include, committing records it permanently.

## Why Does Git Separate These Two Steps?

The separation gives you precise control over what goes into each commit. Without a
staging area, every change in your working directory would be committed together,
making it impossible to group related changes into meaningful, atomic commits.

With staging, users can:
- Work on multiple things simultaneously and commit them separately
- Partially stage a file (using `git add -p`) to commit only specific changes
  within a file
- Review exactly what will be committed before committing it

This is especially useful when you have been working for a while and accumulated
changes across multiple files — staging lets you reconstruct a clean, logical commit
history even from a messy working state.

## When Would You Want to Stage Without Committing?

The most honest answer is that staging is not just a gateway to committing, it is
a revision tool. My own workflow treats staging as an incremental review pass before
a commit is finalized. When working on a feature, I build it in whatever order makes
sense developmentally, then stage changes in deliberate segments to construct a
commit that tells a coherent story, not just a snapshot of wherever I happened to
stop.

This matters because commit history is permanent. Everyone thinks incrementally when
building something, but that incremental thinking does not need to be preserved
verbatim in the history. A commit that arrived through ten messy intermediate states
should still read cleanly. Staging makes that possible without requiring you to slow
down while working.

Some specific scenarios where staging without committing is useful:

- **Grouping related changes:** You changed several files but not all are related.
  Stage the related ones and commit them together, handle the rest in a separate commit.
- **Reviewing before committing:** Stage changes and run `git diff --staged` to
  inspect exactly what will be committed, catching mistakes or unintended changes
  before they enter history.
- **Partial file staging:** Use `git add -p` to stage specific hunks within a file,
  leaving other in-progress changes unstaged for a later commit. Useful when a file
  contains both a complete change and an incomplete one.
- **Constructing clean commits from messy work:** Stage changes in a logical order
  to produce commits that make sense to a future reader, even if the actual
  development order was non-linear.

Related tools that extend this workflow:

- **`git commit --fixup` and `git rebase --autosquash`**: create fixup commits
  that automatically get squashed into their target commit during an interactive
  rebase, keeping the history clean without manual squash editing.
- **`git commit --amend`**: fold staged changes into the previous commit, useful
  for small corrections that do not deserve their own commit.
- **Interactive rebase (`git rebase -i`)**: reorder, squash, edit, or drop commits
  before they are pushed, allowing the history to be refined after the fact.

The underlying philosophy is that a commit is not just a save point, it is a unit
of communication. Staging is what gives you the control to make each commit say
exactly what it should.

## Practical Task

![TASK#42](../../assets/onboarding/Screenshot%202026-05-22%20at%209.16.46 AM.png)
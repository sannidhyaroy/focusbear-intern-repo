# Kanban Workflow

## Research & Learning

### How a Kanban Board Works

A Kanban board is a visual tool for managing workflow. Work items are represented as cards that move through columns from left to right, each column representing a stage in the workflow. The board makes the state of all work visible at a glance: what is waiting, what is in progress, what is blocked, and what is done.

The core mechanism is pull based rather than push based. Team members pull work into the next stage when they have capacity, rather than having work assigned and pushed to them. This prevents overloading individuals and keeps flow steady.

### What the Different Columns on a Kanban Board Represent

Column names vary by team but typically follow this pattern:

- **Backlog:** all work that exists but has not been prioritized or scheduled yet. The full pool of potential work items.
- **Ready:** work that has been prioritized and is ready to be picked up when capacity opens. Moving something here signals it is next in line.
- **In Progress:** actively being worked on. WIP limits typically apply here to prevent overloading individuals.
- **Blocked:** work that cannot proceed due to an external dependency, missing information, or unresolved issue. Making blockages visible is important so they can be resolved rather than silently stalling progress.
- **In Review:** work is complete from the developer's perspective and is waiting for review, verification, or approval before being closed.
- **Done:** work is complete, verified, and closed.

Some teams add custom columns to reflect their specific workflow. For example a team using an automated QA bot might add an `Approved by Bot` column between `In Review` and `Done` to represent the final verification gate.

### How Tasks Move Through the Board

Tasks move left to right as work progresses. The developer is responsible for keeping their own cards updated, like moving a card to `In Progress` when work starts, to `In Review` when a PR is submitted or evidence is added, and so on. Nobody else will move your cards for you in a small async team. Stale cards in the wrong column create confusion about actual progress.

### Benefits of Limiting Work in Progress

WIP limits prevent the common trap of starting many things and finishing none of them. Context switching between multiple in-progress tasks reduces the quality of attention on each. By limiting how many cards can be `In Progress` at once, Kanban forces completion before starting something new. This keeps flow steady, surfaces blockers faster, and produces a more predictable output.

For someone like me who works best in deep focus sessions rather than shallow parallel attention, WIP limits align well with how I naturally work anyway.

---

## Reflection

### How Kanban Helps Manage Priorities and Avoid Overload

The visual nature of the board makes priorities explicit rather than implicit. Instead of holding a mental model of what needs to happen next, the board externalizes it. `Ready` column shows what is next to pick up, `In Progress` shows what is active, and the WIP limit prevents overcommitting.

For an async remote team like Focus Bear, this visibility is especially important. When teammates cannot easily tap each other on the shoulder to ask for a status update, the board does that job passively. Anyone can look at the board and understand where things stand without a meeting.

### How I Can Improve My Workflow Using Kanban Principles

The main habit to build is keeping the board updated in real time rather than in batches. It is easy to do the work and forget to move the card. But a stale board is worse than no board, as it creates false impressions about progress.

I also want to be disciplined about WIP limits. My natural tendency is to start exploring multiple things when I get curious, which is fine for learning but not great for delivery. The board will help me stay honest about what is actually in progress versus what I am just thinking about.

---

## Tasks Completed

### Kanban Board Created

A [GitHub Projects Kanban board](https://github.com/users/sannidhyaroy/projects/4) has been set up for my intern repo with the following columns: `Backlog`, `Ready`, In` Progress`, `In Review`, `Approved by Bot`, and `Done`. All existing issues were imported into `Backlog` automatically.

The `Approved by Bot` column sits between `In Review` and `Done`, reflecting the actual workflow where `FocusBearQA` verification is the final gate before an issue can be closed.

### Tasks Moved Through the Board

- **Agile Workflows and Kanban** moved to `In Progress` as it's currently being worked on
- **Agile Ceremonies and Team Collaboration** moved to `Ready` as it's next to be picked up

### One Way to Improve Task Tracking

Update cards in real time as work progresses rather than doing it at the end of the day or during standup. The board is only useful if it reflects actual current state. Making card updates part of the natural workflow, move to `In Progress` when I start, move to `In Review` when I submit, keeps the overhead minimal and the board accurate.
# Agile Ceremonies

## Research & Learning

### Main Agile Ceremonies and Their Purpose

**Daily Standups**
A short daily sync, typically 15 minutes or less, where team members share what they worked on, what they plan to work on, and any blockers. The goal is not a status report to management but a coordination mechanism for the team. At Focus Bear, standups happen Monday to Friday at 4:00 PM AEST and are facilitated by Manish as Agile PM. The format is freeform in execution but implicitly covers the three standard questions. The structure is there, just not rigidly enforced.

**Sprint Planning (Scrum) vs Continuous Prioritization (Kanban)**
In Scrum, sprint planning is a formal ceremony at the start of each sprint where the team selects items from the backlog and commits to completing them within the sprint. In Kanban there are no sprints, so there is no sprint planning ceremony. Instead, prioritization happens continuously, i.e, items move from `Backlog` to `Ready` as they are refined and prioritized, and team members pull the next `Ready` item when they have capacity.

**Retrospectives**
A retrospective is a structured reflection session where the team reviews how they worked together, identifies what went well, what did not, and what to change going forward. It is about improving the process rather than the product. In Scrum, retrospectives happen at the end of each sprint. In Kanban they can happen at any cadence or when the team feels it is needed. Focus Bear conducts OKR meetings which serve a similar alignment purpose, though I have not yet attended one as a new intern.

**Backlog Refinement**
Backlog refinement is the ongoing process of reviewing, clarifying, and prioritizing items in the backlog so they are well defined and ready to be picked up. In Scrum it is a formal ceremony. In Kanban it happens continuously and informally, items are refined until they have enough information to be moved to `Ready`. This is less a ceremony and more a habit of keeping the backlog in good shape.

### How Agile Teams Collaborate Asynchronously and Across Time Zones

Async collaboration in Agile relies on making information visible without requiring everyone to be online simultaneously. Key practices include:

- Keeping the Kanban board updated in real time so anyone can see progress without asking
- Using written communication channels like Discord or comments on issues for non urgent questions
- Documenting decisions and context in issues, PRs, and commit descriptions so teammates in different time zones can catch up without a meeting
- Escalating to synchronous communication only when genuinely needed

At Focus Bear, the team spans multiple time zones. The standup at 4:00 PM AEST serves as the one daily sync point, with async Discord and GitHub communication handling everything else.

---

## Reflection

### How Agile Ceremonies Help with Communication and Alignment

Ceremonies create predictable touchpoints in an otherwise async environment. The daily standup creates a fixed time means everyone knows when they will hear from the team, which reduces the anxiety of not knowing what others are working on. It also creates a natural moment to surface blockers before they silently stall progress for a full day or more.

From observing past meetings, the standup at Focus Bear serves more than just status updates. It is where process decisions get made. For example, clarifying that tasks closed by the QA bot still require human verification with evidence before moving to `Done`, or confirming which UI features are available in which app modes. These are decisions that would otherwise require multiple async messages to resolve, since everything else being async, so that 15 minute window carries a lot of coordination weight.

### Most Important Ceremony for My Role

**Daily Standup** is the most important ceremony for my role as a Mac Developer Intern.

On personal projects I have never done retrospectives formally. If I notice something wrong I write a detailed issue and address it separately. Backlog refinement happens naturally and continuously. Sprint planning is not relevant since Focus Bear uses Kanban.

The standup is the one ceremony that directly affects my day to day work. It is where I communicate progress, flag blockers, and stay connected to what the rest of the team is doing. Given that my natural working style is async and solo, the standup is the one structured forcing function that keeps me visible and accountable to the team rather than disappearing into deep focus sessions with no external check in.

---

## Tasks Completed

### Attended Standups and Observed How Updates Are Shared

I have attended multiple standups since joining on May 11th, and taken a look at a few earlier standups for more understanding and context. The format is freeform in execution but implicitly covers the three standard questions. Nobody enforces a rigid structure, but progress, plans, and blockers emerge naturally from each person's update. Manish facilitates by keeping things moving and following up on anything that needs clarification.

Notable observations from standup meetings:

- **Process decisions happen in standups:** The QA workflow was clarified in a standup that tasks closed by the QA bot still require human verification with screenshots or video evidence before moving to `Done` status.
- **Feature status is communicated here:** The removal of Menu Tour from the Mac app starting from version V3 was surfaced and documented during a standup, ensuring team members knew not to test for or reference it.
- **Blockers get unblocked:** The QA bot's video evidence recognition issue was raised in standup, leading to the workaround of supplementing video with screenshots to improve AI recognition accuracy.
- **Mac development is currently on hold** while the team focuses on other areas. This was communicated in standup, which meant our QA intern continued addressing legacy issues on older versions rather than waiting for new builds.

### Retrospective (Observations from Standup Summaries)

Since Focus Bear does not conduct formal sprint retrospectives and I have not yet attended an OKR meeting as a new intern, I reviewed past standup summaries from Fireflies to identify recurring themes, improvements discussed, and action items that reflect the team's self-improvement process.

**What is working well:**
- The standup consistently surfaces process clarifications that prevent confusion: QA workflows, feature availability, and version documentation are regularly aligned here
- The team has a healthy culture of documenting decisions as GitHub comments for traceability, which Manish actively encourages
- Cross-functional coordination between Mac dev, Windows dev, QA, and PM is happening in a single standup rather than siloed by role, which keeps everyone informed

**What could be improved:**
- The QA bot's inability to clearly read video evidence is causing tasks to revert from QA Passed back to `In Progress`, disrupting workflow. A fallback process or clearer evidence guidelines would reduce this friction.
- Onboarding documentation gaps are causing repeated questions from new interns about the QA bot (as seen in Discord channels too), process expectations, and tool setup. Better upfront documentation would reduce the support load on the team.
- Mac development being on hold while other areas take priority creates uncertainty for Mac team members about what to work on. Clearer communication of priority shifts would help.

**Action items observed from a few recent Windows/Mac Standups:**
- QA Intern: supplement video evidence with screenshots to improve QA bot recognition
- Manish: update Permissions tab visibility to be consistent across Simple and Geek modes
- Legacy issues tied to old UI patterns to be marked as non-relevant with version comments to reduce QA backlog clutter

### One Change to Improve Team Collaboration

Update Kanban board cards in real time as work progresses rather than at the end of the day or during standup. The standup observations show that the team relies on card status for coordination, so when cards are stale, it creates confusion about actual progress. Making card updates a natural part of the workflow rather than an afterthought keeps the board accurate and reduces the number of status questions that need to surface in standup.
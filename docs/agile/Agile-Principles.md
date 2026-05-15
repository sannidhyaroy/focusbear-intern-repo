# Agile Principles

## Research & Learning

### What is Agile and How Does It Differ from Traditional Project Management?

Traditional project management, most notably the Waterfall model, follows a linear sequential approach. Requirements are defined upfront, then design, then development, then testing, then deployment. Each phase completes before the next begins. The assumption is that requirements are stable and knowable in advance.

Agile rejects this assumption. It acknowledges that requirements change, understanding evolves, and early feedback is more valuable than a perfect plan. Instead of one long cycle, Agile breaks work into short iterative cycles where working software is delivered frequently and adjusted based on real feedback.

The core shift is from predictive planning to adaptive delivery.

### Core Values and Principles of Agile

The Agile Manifesto defines four core values:

- Individuals and interactions over processes and tools
- Working software over comprehensive documentation
- Customer collaboration over contract negotiation
- Responding to change over following a plan

This does not mean the right side has no value, it means the left side is prioritized when tradeoffs arise.

The 12 principles behind the manifesto emphasize frequent delivery of working software, welcoming changing requirements, sustainable pace, technical excellence, simplicity, self organizing teams, and regular reflection on how to improve.

### Differences Between Scrum and Kanban

**Scrum** is a structured framework built around fixed length iterations called sprints, typically two weeks long. It defines specific roles like Scrum Master, Product Owner, Development Team and ceremonies including sprint planning, daily standups, sprint review, and retrospectives. Work is pulled from a backlog into a sprint, and the scope of that sprint is fixed for its duration. Scrum works well for teams with relatively stable, project based workloads where planning in fixed chunks makes sense.

**Kanban** is a continuous flow system with no fixed sprints or defined roles. Work items move through columns on a board, typically To Do, In Progress, and Done. The key mechanism is limiting work in progress to prevent bottlenecks and maintain flow. There are no ceremonies required, no fixed cadence, and no scope commitments. New work can be pulled in as capacity opens up.

In short: Scrum is structured and sprint based, Kanban is continuous and flow based.

### Why Focus Bear Leans Toward Kanban

Several characteristics of Focus Bear's environment make Kanban a better fit than Scrum:

- Small team with interns rotating in and out, hence Scrum's fixed roles and ceremonies don't scale down gracefully
- Async remote team across multiple timezones, but sprint ceremonies require synchronous participation that is difficult to coordinate globally
- Ongoing product development rather than project based work, so Kanban's continuous flow suits a product that is always evolving
- Lower overhead as no sprint planning or retrospectives required, just keep the work moving

---

## Reflection

### Biggest Benefits and Challenges of Agile

**Benefits:**
- Flexibility to respond when requirements change or new information emerges
- Frequent delivery means problems surface early rather than at the end of a long cycle
- Continuous feedback keeps the work aligned with actual needs rather than assumptions made months ago
- Sustainable pace as Agile explicitly values not burning people out

**Challenges:**
- Without discipline, flexibility can become an excuse to never finish anything
- Documentation can be deprioritized in favor of moving fast, creating problems for future maintainers or teammates
- Requires genuine collaboration and trust, because Agile does not work well if people are siloed or communication breaks down
- For someone like me who works in long deep focus sessions, frequent check ins and context switching can be disruptive to flow

### How Agile Principles Can Improve My Role

The principle that maps most naturally to how I already work is **responding to change over following a plan**. I naturally adapt rather than rigidly follow a predetermined path, and I'm comfortable pivoting when new information changes the picture.

The principle I need to be more deliberate about is **working software over comprehensive documentation**, but perhaps not in the way it's usually framed. Historically my relationship with documentation has been exactly what that principle warns against in reverse: I ship the code and tell myself documentation can wait, and then it never happens. My Unity game from five years ago is the most extreme example, a large solo project I stepped away from during exams and never returned to, partly because I had no documentation trail and re-entering my own codebase felt like archaeology. Similar patterns exist across many of my projects.

The honest version of that principle for me is: ship working software, but leave enough of a trail that future-you, or a teammate isn't completely lost. The deep rabbit hole context, the specific edge cases, the "why did I do it this way" reasoning are those things that evaporate fastest and matter most when someone needs to continue the work. Nowadays, AI is good at documentation tasks, so I do use it to generate detailed markdown notes during deep work sessions specifically to capture that context for the future-me before it disappears.

---

## Tasks Completed

### Summary of Main Differences Between Scrum and Kanban

Scrum organizes work into fixed length sprints with defined roles and required ceremonies. It works best for project based teams with relatively predictable workloads. Kanban organizes work as a continuous flow through a visual board, limits work in progress, and has no fixed cadence or required roles. It works best for teams with ongoing, variable workloads where flexibility matters more than structure. Focus Bear uses Kanban because its small, async, globally distributed team with rotating interns fits Kanban's low overhead and continuous flow model better than Scrum's ceremonial structure.

### One Agile Principle Most Useful in My Work

**Responding to change over following a plan.**

In practice this means staying adaptive when requirements shift, new information emerges, or a better approach becomes apparent mid task. It also means not being precious about plans that no longer serve the actual goal. The plan exists to serve the work, not the other way around.
# AI Usage Guidelines

## Research & Learning

### AI Tools Used for My Role

**Claude (claude.ai):**
- Drafting and structuring written communication like emails, texts, documentation
- Structuring raw thoughts into a form others can receive clearly, because expressing myself precisely in writing matters a lot to me and AI helps bridge the gap between what I think and what others receive
- Discussing code concepts, approaches, and decisions at a high level without needing direct codebase access
- A thinking partner for working through complex decisions, anxiety, and spiraling thoughts

**Claude Code:**
- Exploring and understanding foreign codebases, pulling up interconnected code blocks across classes and objects, visualizing hierarchy chains and dependency relationships
- Brainstorming and making architectural decisions with full codebase context
- Generating boilerplate and scaffolding
- Writing detailed commit descriptions and PR summaries from actual code changes
- Code review with granular, permission-based edits as each change requires explicit approval with the option to decline with a reasoning, which keeps me in control of every decision rather than blindly accepting output
- Occasional code generation, used with high scrutiny and granular, permission-based control

### Benefits and Risks of AI in a Professional Setting

**Benefits:**
- Accelerates understanding of unfamiliar codebases significantly
- Improves documentation quality like comments, commit descriptions, PR summaries, and release notes that would otherwise be sparse or skipped entirely
- Helps translate raw, accurate thinking into communication others can receive without misinterpretation
- Useful thinking partner for brainstorming and learning with full context awareness

**Risks:**
- Over-reliance can erode independent problem-solving ability over time
- AI-generated content can be confidently wrong, especially on niche, recent, or domain-specific topics
- Confidential information entered into AI tools may be used for model training or exposed in ways that violate data privacy
- Accepting output without understanding it creates invisible technical debt and bugs that are hard to catch later

### Information That Should Never Be Entered Into AI Tools
- Proprietary source code containing business logic or trade secrets
- User data, personal information, or anything covered under GDPR
- API keys, credentials, tokens, or secrets of any kind
- Internal business strategy, unreleased features, or confidential roadmap details
- Focus Bear user data or any information about internal systems not intended for external disclosure

### How to Fact-Check and Validate AI-Generated Content
- Never treat AI output as ground truth, treat it as a starting point
- Cross-reference technical claims against official documentation
- Test generated code in isolation before integrating
- Review AI-generated writing carefully for tone, accuracy, and whether it actually represents what you intended to say
- If you can't explain or defend the output, usually that could a signal to learn more about it, not a reason to avoid using it, but a reason to understand it before shipping it

---

## Reflection

### When to Use AI vs. Rely on Your Own Skills
AI is most useful for:
- Tasks where the bottleneck is expression rather than thinking like structuring, drafting, documenting
- Rapidly orientating in an unfamiliar codebase
- Repetitive or boilerplate work that doesn't require deep judgment
- Brainstorming and architectural exploration with a context-aware partner
- First drafts of anything that will be critically reviewed afterward

Relying on my own skills is more appropriate for:
- Core problem-solving and final judgment calls
- Anything requiring genuine understanding rather than just output
- Situations where I need to own and defend the decision fully

The boundary I try to maintain: AI assists and amplifies the thinking, it doesn't replace it. If I can't understand or explain what it produced, that's a learning opportunity, not a green light to ship or a red light to drop it.

### Avoiding Over-Reliance While Still Benefiting
My approach is iterative and collaborative rather than generative and accepting.
Everything AI produces gets reviewed, questioned, and usually tweaked. I'm opinionated about which tools I use specifically because some models treat every request as an opportunity to dump output, while others leave space for me to stay in control of the process and push back when something is wrong.

### Ensuring Data Privacy When Using AI Tools
- No proprietary Focus Bear code or user data goes into any AI tool
- Sensitive context is described abstractly rather than shared literally where possible
- I default to checking Focus Bear's data handling policies before using any new AI tool for work-related tasks

---

## Tasks Completed

### One Task Improved Using AI
**Commit descriptions, PR summaries, and release notes.**

Detailed commit descriptions documenting the why, the what, and associated context are genuinely rare because nobody enjoys documentation work. Using Claude to draft these from my own understanding of the change has made my commits consistently well-documented. PR summaries and release notes are then generated from the collection of those commit descriptions, creating a documentation chain that would otherwise simply not exist.

### Critical Review of AI Output
Yes, it requires editing. Everything AI generates goes through an iterative review and refinement cycle, not a single pass. The communication-structuring use case is a good example: I use AI to translate my raw thinking into a form others can receive without misinterpretation, but the thinking itself and the final judgment on whether the output actually represents what I meant is always mine. I edit, nudge the AI further, edit again, and continue until I'm satisfied the output genuinely represents what I intended. After a final audit, I either push it if I'm confident enough, have the same AI review it with fresh context to catch anything I missed, or cross-check with a different model entirely. The process ends when I'm satisfied, not when the AI is done.

### AI Attribution Practice
I follow a transparency-first attribution approach, even though everything is independently audited by me:

- **Co-author tag** (e.g. `Co-Authored-By: Claude Sonnet 4.6 <no-reply@anthropic.com>`) on any commit where AI generated actual code that made it into the final commit
- **Issue-Reported-By** message at the end of commit descriptions to label commit for bugs or issues primarily discovered by AI
- **NOTE** at the end of commit descriptions for AI-generated translations, since translations are the one area I genuinely cannot fully audit myself
- No attribution for commit descriptions, PR summaries, emails, or written communication. These are different in nature as the source thoughts, reasoning, and intent are entirely mine from start to finish. AI helps find the right words and structure the expression, and even after that is heavily scrutinized to check if the wordings really represent my thoughts well, so there's no separable AI contribution to attribute. It's closer to using a thesaurus than a co-author.

The underlying principle is transparency for others. I want people to know when AI generated something materially present in the artifact, regardless of how much I reviewed it.

### Best Practice I Will Follow at Focus Bear
I will use AI to amplify what I know, but it really doesn't substitute for knowing it. Before shipping anything AI generated, I ask: do I understand this well enough to defend it if someone questions it? If not, I treat that as a signal to learn more, not as permission to ship blind. The goal is always that AI raises the floor of what I produce, not that it removes me from the loop.
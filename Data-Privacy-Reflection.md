# Data Privacy Reflection

## Research & Learning

### Key Takeaways from Focus Bear's Privacy Policy

Focus Bear's privacy policy is GDPR compliant, which means it follows one of
the strictest data protection frameworks in the world. Key points relevant
to working as an intern:

- Focus Bear collects several categories of user data including identification
  data, habit data, health related survey responses, device and technical data,
  and payment information
- Habit data and health related data are double encrypted, meaning even Focus
  Bear staff cannot read them unless a user explicitly reports a problem and
  requests investigation
- User data is shared with trusted third party processors including AWS,
  Auth0, OpenAI, Stripe, Discord, and others, all operating under GDPR or
  equivalent frameworks
- OpenAI is used specifically for generating personalised morning motivational
  messages and deciding which websites to allow during work hours
- Users have full GDPR rights including access, rectification, erasure,
  portability, and the right to object
- Data is retained only as long as necessary for the purpose it was collected

The most important implication for me as an intern is that user data is
sensitive by design. Focus Bear's users share health related information,
daily habits, and focus patterns. That context carries ethical weight beyond
just legal compliance.

### What Types of Data Are Considered Confidential at Focus Bear?

- User personal data including email addresses, device information, and
  payment details
- User habit data and health survey responses, which are double encrypted
- Internal business information including unreleased features, roadmap details,
  and company strategy
- Any data about team members, supervisors, or internal operations
- Source code, architecture decisions, and proprietary systems
- Communications between team members not intended for external sharing

### Best Practices for Handling Confidential Data

- Never share user data or internal information outside of approved channels
- Do not enter proprietary Focus Bear data into external AI tools or services
- Use strong, unique passwords and 2FA for all work accounts
- Lock devices when stepping away, even briefly
- Share files through approved platforms only, not personal accounts or
  unvetted services
- When in doubt about whether something is confidential, assume it is and ask

### Responding to a Suspected Data Breach or Accidental Disclosure

1. Do not attempt to cover it up or handle it alone
2. Immediately notify the Focus Bear team through the appropriate channel
3. Document what happened, what data was involved, and how it occurred
4. Stop any ongoing exposure if possible
5. GDPR requires Focus Bear to notify the relevant supervisory authority within
   72 hours of becoming aware of a breach, so speed matters
6. Contact privacy@focusbear.io for privacy related issues

---

## Reflection

### Steps to Handle Data Securely in Daily Tasks

- Keep work and personal accounts clearly separated, if possible
- Never paste user data or internal code into external AI tools without
  abstracting sensitive details first
- Treat anything seen in the codebase or internal communications as
  confidential by default
- Use Discord and approved tools for team communication rather than personal
  channels

### Storing, Sharing, and Disposing of Sensitive Information

- Store work files in approved platforms only
- Share information only with people who have a legitimate need for it
- When something is no longer needed, delete it properly rather than letting
  it accumulate in personal storage
- Do not screenshot or export internal data outside of approved workflows

### Common Mistakes That Lead to Data Privacy Issues

- Entering real user data into AI tools for testing purposes instead of using
  anonymised or synthetic data
- Sharing internal information casually in public channels or personal chats
- Reusing passwords across accounts
- Leaving devices unlocked in shared spaces, when not actively using them
- Forwarding work emails to personal accounts for convenience

---

## Tasks Completed

### One Habit or Practice to Improve Data Security

I will treat the boundary between internal and external tools as a hard line.
Anything that touches real user data or proprietary code stays inside approved
internal systems. When I need AI assistance on something work related, I will
describe the problem abstractly rather than pasting actual code or data.

### Key Learning or Security Measure to Implement

Focus Bear's users share genuinely sensitive information, including health
conditions and daily habits. The double encryption on habit data reflects how
seriously this is taken. As someone contributing to the Mac app, I want to
internalize that privacy is not a compliance checkbox here. It is a core part
of the product's trust relationship with its users, many of whom are
neurodivergent and already in a vulnerable position when they choose to share
that information.
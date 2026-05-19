# First-Time User Experience: Onboarding Observations

**App Version:** 3.31.474 (macOS)

**Date:** 20th May 2026

**Approach:** Fresh anonymous login with full onboarding flow documented via screenshots

---

## What Works Well

### Warm and Engaging Character Design
The bear character and its variants (pirate, ninja, wizard) are charming and create an emotionally warm first impression. For a product targeting neurodivergent users who may have had frustrating experiences with productivity tools, this tone is genuinely appropriate and differentiating.

### Goal Selection Screen
The "What are your goals?" screen is well designed with clear categories, good visual
hierarchy, and pre-selected sensible defaults. This is one of the strongest screens in
the onboarding.

**Screenshot:**
![Goal Selection](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.54.38 AM.png)

### Privacy Reassurances Are Well Placed
The privacy reassurance screens, both the general privacy screen during account creation and the AI blocking screen do a good job of proactively addressing concerns before users have to ask. The three-card layout is clear and scannable.

**Screenshots:**
![Privacy](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.53.07 AM.png)
![AI Privacy](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.55.48 AM.png)

### Profession-Based Website Suggestions
Asking for the user's profession and then suggesting relevant work websites to whitelist is a genuinely smart UX decision. It reduces setup friction significantly.

**Screenshot:** ![Distraction Blocking Suggestions](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.56.40 AM.png)

### Bear Speech Bubbles Explaining Permissions
Each macOS permission request has a bear speech bubble explaining why it is needed.
Permissions dialogs are inherently anxiety-inducing, and the friendly contextual
explanation helps considerably.

**Screenshots:**
![Grant System Event Permissions](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.58.53 AM.png)
![Grant Accessibility Permissions](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.59.13 AM.png)
![Grant Browser Permissions](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.59.26 AM.png)

---

## Issues, Confusion Points, and Improvement Opportunities

### 1. The App Never Explains What It Actually Does

The entire pre-login onboarding flow, from "Howdy! I'm Focus Bear Junior" to account
creation, does not explain what Focus Bear actually does at a feature level. After going
through all these screens, a new user knows the bear has ADHD and wants to team up, but
has no idea that the app has habits, focus sessions, scheduled blocking, or routines as
distinct concepts. The onboarding talks about habits, routines, and scheduled blocking
without first establishing a shared mental model of what these things are and how they
relate.

A brief one-screen overview of the three core concepts early in the flow would
dramatically reduce the confusion that new users experience in the first few days:

- **Habits:** daily routines (morning, evening) that guide you through repeated tasks
- **Scheduled Blocking:** pre-scheduled distraction blocking for recurring work hours
- **Focus Sessions:** flexible, on-demand blocking for ad hoc deep work with task and
  micro-break tracking

---

### 2. "I Never Had That Issue" Breaks the Narrative Flow

On the second screen, the bear introduces itself as having ADHD and getting distracted. Two choices are presented: "Me too!" and "I never had that issue." Selecting "I never had that issue" skips the "Want to team up? We can focus together!" screen entirely and jumps directly to account creation.

This breaks the narrative rhythm and means users who select this option miss the emotional hook that frames the product's purpose. Even users without ADHD may benefit from Focus Bear, and losing the value proposition framing for this group is a missed opportunity.

**Screenshots:**
![Bear ADHD](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.52.24 AM.png)
![Team up with Bear](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.52.50 AM.png)

---

### 3. Focus Sessions Are Never Mentioned in Onboarding

The entire onboarding sets up habits and scheduled blocking, but Focus Sessions, a core
feature of the app, are never mentioned once. A new user completing onboarding has no
idea Focus Sessions exist, what they are for, or how they differ from scheduled blocking.

---

### 4. Habits and Blocking Are Set Up as Separate Unrelated Flows

The habit setup flow and the distraction blocking setup flow are presented sequentially with no explanation of how they relate to each other. A new user has no mental model for when to use habits versus scheduled blocking versus focus sessions after completing onboarding.

This directly causes the most common new user mistake like I did: adding "work" as a habit rather than a scheduled block, which then locks the user out of other features until the routine is complete.

---

### 5. "Tap on the + Button" is Wrong Platform Language on macOS

On the "Choose apps to block" screen, the placeholder text reads "Tap on the + button to block a new app." This is mobile language. On macOS, users click, they do not tap. This could be taken from the mobile codebase that was never updated for the desktop version.

**Screenshot:** ![Choose apps to block](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.57.15 AM.png)

---

### 6. Three Consecutive macOS Permission Dialogs With No Overview

At the end of the blocking setup, the app requests three separate macOS permissions in
sequence: System Events, Accessibility, and Browser permissions. There is no upfront
explanation of how many permissions are needed or why all three are required.

For a neurodivergent user who may already be fatigued from the long onboarding flow,
three consecutive system permission prompts without any warning is genuinely
overwhelming. A single transition screen before the sequence saying "We need three
permissions to make blocking work, here is why" would significantly reduce friction and
drop-off.

---

### 7. Privacy Checkbox With No Explanation for Greyed Out Continue Button

On the Privacy and Security screen, the Continue button is greyed out until the user
checks the agreement checkbox. There is no visual indicator or tooltip explaining why
Continue is disabled. A user who taps Continue and nothing happens has no immediate
feedback about what action is required.

![Privacy Screen](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.53.07 AM.png)

---

### 8. Incorrect System App Name for Current macOS Versions

The Grant Accessibility Permissions screen instructs users to navigate to `System
Preferences > Privacy & Security > Accessibility.` However, Apple renamed System
Preferences to System Settings in macOS Ventura (13) and later. Users on modern macOS
versions will not find "System Preferences" and may get confused.

**Screenshots:**
![Grant Accessibility Permissions](../../assets/onboarding/Screenshot%202026-05-19%20at%2010.59.13 AM.png)

--- 

### 9. Proceed Button on Accessibility Permissions Screen is Greyed Out and Unresponsive

On the Grant Accessibility Permissions again, the Proceed button is greyed out and
requires multiple clicks before it becomes active. There is no visual feedback explaining
why it is disabled or what the user needs to do first. This behavior is consistent and
reproducible both during onboarding and when accessing the permissions screen outside of
onboarding. It appears the button's enabled state is not being correctly re-evaluated
after the user grants the permission in System Settings.

---

## Improvement Ideas

### Idea 1: Add a Single "How Focus Bear Works" Overview Screen

Add one screen early in the post-login onboarding that visually explains the three core
concepts and when to use each. A simple three-card layout would be sufficient. This
single addition would prevent the majority of new user confusion experienced in the
first week.

### Idea 2: Add a Transition Screen Before the Permission Request Sequence

Before the three macOS permission dialogs, add a single screen that says something
like: "Almost done! We need three quick permissions to make blocking work." with a
brief one-line explanation of each. This sets expectations, reduces anxiety, and makes
it less likely that users abandon setup partway through.

---

## Summary

The onboarding does a good job of establishing emotional warmth and collecting setup
information. The character design, goal selection, and privacy handling are genuine
strengths. The critical gap is that the app never explains its own core mental model,
leaving new users to discover through trial and error how habits, focus sessions, and
scheduled blocking relate to each other. This is especially problematic for the target
audience, who already struggle with ambiguity and cognitive overload.
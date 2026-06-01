# Automator / Shortcuts Workflow

## Join Standup Meeting at Focus Bear

A Shortcuts workflow that automates the pre-standup routine with smart checks before joining the daily standup meeting.

**Exported shortcut:** [`Join Standup Meeting at Focus Bear.shortcut`](../../assets/Join%20Standup%20Meeting%20at%20Focus%20Bear.shortcut)

### What it does

1. **Day check:** exits with an alert if it is a weekend
2. **Time check:** exits with an alert if it is outside the 11:20 AM – 12:00 PM IST standup window
3. **Battery check:** shows an alert if battery is below 30%, prompting to plug in before the meeting
4. **Quits Soduto:** closes the KDE Connect client to avoid notification noise during the meeting
5. **Opens the standup link:** joins directly in with my correct Google account via `?authuser=1`

The shortcut is accessible via Spotlight/Raycast (`Cmd + Space` → "Join Standup") or assigned to a keyboard shortcut. 😄

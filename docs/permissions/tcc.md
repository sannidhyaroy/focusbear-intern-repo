# TCC System Overview

## What is TCC?

Transparency, Consent, and Control (TCC) is the macOS privacy framework that governs which applications can access sensitive user data and system resources. Introduced in macOS Mojave and expanded significantly in subsequent releases, TCC intercepts access attempts to protected resources and either prompts the user for permission or denies access silently based on previously granted permissions.

TCC is enforced at the kernel level. Even root processes cannot bypass it without the user explicitly granting access through System Settings.

## Protected Resources

TCC covers a broad and growing set of resources:

### Data

- Contacts
- Calendars
- Reminders
- Photos
- Camera
- Microphone
- Location Services
- Health data
- HomeKit
- Media and Apple Music library

### System

- Full Disk Access: Access to files outside the app's sandbox
- Screen Recording: Capture of screen content
- Accessibility: Control of other apps via Accessibility APIs
- Input Monitoring: Monitoring of keyboard and mouse input
- Speech Recognition
- Focus Status

### Network and Communication

- Local Network: Discovery of devices on the local network
- Bluetooth

## How TCC Works

When an app attempts to access a TCC-protected resource for the first time, macOS intercepts the request and displays a permission prompt to the user. The user can allow or deny. The decision is stored in the TCC database and applied to all subsequent requests from that app without prompting again.

Apps must declare which protected resources they intend to access in their `Info.plist` using purpose strings, that are human-readable descriptions shown in the permission prompt. An app that attempts to access a protected resource without declaring a purpose string will crash rather than prompt.

```xml
<key>NSCameraUsageDescription</key>
<string>This app uses the camera to scan QR codes.</string>

<key>NSMicrophoneUsageDescription</key>
<string>This app uses the microphone for voice input.</string>
```

## The TCC Database

TCC decisions are stored in SQLite databases:

```bash
~/Library/Application Support/com.apple.TCC/TCC.db  # user-level decisions
/Library/Application Support/com.apple.TCC/TCC.db   # system-level decisions
```

The user-level database is readable without elevated privileges. The system-level database requires Full Disk Access or root. Modifying either database directly is not supported and is prevented by System Integrity Protection on modern macOS.

## Resetting Permissions

Permissions can be reset per-app via System Settings > Privacy and Security, or via the command line using `tccutil`:

```bash
# Reset all permissions for an app
tccutil reset All com.biolume.Registry

# Reset a specific permission
tccutil reset Camera com.biolume.Registry

# Reset all permissions for all apps (requires SIP disabled)
tccutil reset All
```

Resetting causes the app to prompt again on the next access attempt.

## System Integrity Protection and TCC

System Integrity Protection (SIP) works alongside TCC to prevent even privileged processes from modifying TCC databases or bypassing protections. Disabling SIP weakens TCC enforcement significantly, which is why it should remain enabled in production environments.

## App Sandbox and TCC

Sandboxed apps have an additional layer of restrictions on top of TCC. A sandboxed app must declare entitlements for any resources it needs access to, and those entitlements must be approved before the app can even request TCC permission from the user. Non-sandboxed apps only need to declare purpose strings and handle TCC prompts, they are not limited by entitlement declarations at the sandbox level.

Mac App Store apps are required to be sandboxed. Apps distributed outside the App Store can be sandboxed or non-sandboxed, though sandboxing is encouraged as a security best practice.

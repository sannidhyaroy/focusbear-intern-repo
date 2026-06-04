# Code Signing Basics

## What is Code Signing?

Code signing is a cryptographic mechanism that lets macOS verify the identity of the developer who built an app and confirm that the binary has not been modified since it was signed. Every app that runs on macOS is signed in some form.

## Certificates

A signing certificate ties a public/private key pair to a developer identity. The private key signs the binary, and macOS uses the corresponding public key to verify the signature at launch. There are three tiers:

**Apple Development:** Available with a free Apple Developer account. Xcode manages this automatically when an Apple ID is signed in and a team is selected under `Signing and Capabilities`. Sufficient for building and running apps locally and distributing builds to people who trust your certificate manually.

**Developer ID Application:** Requires a paid Apple Developer Program membership ($99/year). Used for distributing apps outside the Mac App Store to anyone, without requiring the user to manually trust the certificate. Apps signed with Developer ID can be notarized by Apple. Without Developer ID, users see a Gatekeeper warning on first launch because macOS does not trust Apple Development certificates for third-party distribution.

**Apple Distribution:** Also requires a paid membership. Used exclusively for Mac App Store submissions.

## Ad-hoc Signing

Ad-hoc signing uses a local identity rather than an Apple certificate. The signature only verifies that the binary has not been tampered with since signing, it does not establish any developer identity. Ad-hoc signed apps trigger Gatekeeper warnings on other machines and cannot be notarized. It is a step below even a free Apple Development certificate.

## Gatekeeper

Gatekeeper is the macOS enforcement mechanism for code signing. When a user opens a downloaded app, Gatekeeper checks whether the app is signed and whether the certificate is trusted for distribution. Apps signed with an Apple Development certificate from a free account are not trusted for distribution, so users see a warning. The workarounds are:

- Go to `System Settings` > `Privacy and Security` and click `Open Anyway`
- Remove the quarantine flag before opening:

  ```bash
  xattr -d com.apple.quarantine /path/to/App.dmg
  ```

- On macOS Sonoma and earlier, right-click the app and select `Open` while holding `Control (⌃)`

## Notarization

Notarization is a separate process where Apple scans a signed binary for known malware and issues a ticket stapled to the app. When a notarized app is opened, Gatekeeper verifies the ticket and skips the warning dialog. Notarization requires a Developer ID certificate and a paid Apple Developer account.

## Entitlements

Entitlements are key-value pairs embedded in the signed binary declaring which capabilities the app is allowed to use like network access, iCloud, push notifications, camera, microphone, and so on. The signature covers the entitlements, so they cannot be modified after signing without invalidating the signature.

## Hardened Runtime

The hardened runtime restricts what a signed app can do at runtime, like preventing code injection, disabling certain debugging capabilities, and requiring explicit entitlements for sensitive operations. Notarization requires the hardened runtime to be enabled.

## Provisioning Profiles

Provisioning profiles are primarily an iOS concern. On macOS, apps distributed outside the App Store rely on the Developer ID certificate and notarization rather than provisioning profiles. Mac App Store distribution requires a provisioning profile that ties the app to specific approved entitlements.

## Automatic vs Manual Signing in Xcode

Xcode can manage signing automatically, like creating and rotating certificates as needed, or manually, where the developer specifies exactly which certificate to use. Automatic signing is sufficient for most workflows. Manual signing is needed for CI/CD pipelines where Xcode cannot interactively create certificates, or for advanced multi-target configurations with different entitlements per target.

## `dSYM` and Crash Symbolication

When a release build strips debug symbols from the binary, Xcode generates a dSYM bundle alongside the archive. When a crash report arrives from a user, the dSYM symbolication maps raw memory addresses back to readable function names and line numbers. For apps distributed via Sparkle, the dSYM bundle should be stored alongside each release. Without it, crash reports from users would be unreadable.

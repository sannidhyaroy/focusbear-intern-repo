# Sandbox Entitlements

## What is the App Sandbox?

The App Sandbox is a macOS security mechanism that restricts what a running application can access by default. A sandboxed app runs in an isolated container and can only access its own files, memory, and resources unless it explicitly declares additional capabilities through entitlements.

Sandboxing is required for Mac App Store distribution. Apps distributed outside the App Store can opt in voluntarily, which is encouraged as a security best practice.

## What are Entitlements?

Entitlements are key-value pairs declared in a `.entitlements` file and embedded in the signed binary. They tell the system which capabilities and resources the app is allowed to use. The signature covers the entitlements, so they cannot be modified after signing without invalidating the signature.

Entitlements work alongside TCC, an app needs both the relevant entitlement declared and the user's TCC permission granted before it can access a protected resource.

## Entitlements File

Xcode generates an `.entitlements` file automatically when a project is created. It is a standard property list in XML format:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

    <!-- Enable the App Sandbox -->
    <key>com.apple.security.app-sandbox</key>
    <true/>

    <!-- Outgoing network connections (required for any internet access) -->
    <key>com.apple.security.network.client</key>
    <true/>

    <!-- Incoming network connections (required for servers and peer-to-peer) -->
    <key>com.apple.security.network.server</key>
    <true/>

    <!-- Read-only access to the user's Downloads folder -->
    <key>com.apple.security.files.downloads.read-only</key>
    <true/>

    <!-- Read/write access to the user's Downloads folder -->
    <key>com.apple.security.files.downloads.read-write</key>
    <true/>

    <!-- Access to files the user explicitly opens via open panel -->
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>

    <!-- Camera access (also requires NSCameraUsageDescription in Info.plist) -->
    <key>com.apple.security.device.camera</key>
    <true/>

    <!-- Microphone access (also requires NSMicrophoneUsageDescription) -->
    <key>com.apple.security.device.microphone</key>
    <true/>

    <!-- Bluetooth access -->
    <key>com.apple.security.device.bluetooth</key>
    <true/>

    <!-- Access to the user's Contacts database -->
    <key>com.apple.security.personal-information.addressbook</key>
    <true/>

    <!-- Access to the user's Location -->
    <key>com.apple.security.personal-information.location</key>
    <true/>

    <!-- Hardened Runtime: allow JIT compilation (e.g. JavaScript engines) -->
    <key>com.apple.security.cs.allow-jit</key>
    <true/>

    <!-- Hardened Runtime: allow unsigned executable memory -->
    <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
    <true/>

    <!-- Hardened Runtime: disable library validation (load unsigned frameworks) -->
    <key>com.apple.security.cs.disable-library-validation</key>
    <true/>

    <!-- App Groups: share data between app and extensions -->
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.com.example.MyApp</string>
    </array>

</dict>
</plist>
```

## Key Entitlements Explained

### Sandbox

`com.apple.security.app-sandbox` enables sandboxing. Without this set to true, none of the other sandbox entitlements have any effect, the app runs without restrictions.

### Network

`com.apple.security.network.client` allows outgoing TCP and UDP connections. Required for any app that makes network requests like REST APIs, WebSocket connections, or any client-side networking.

`com.apple.security.network.server` allows incoming connections. Required for apps that listen on a port like local servers, peer-to-peer apps, or anything implementing a network protocol.

### File Access

By default, a sandboxed app can only read and write its own container directory. Additional file access requires explicit entitlements:

`com.apple.security.files.user-selected.read-write` grants access to files the user explicitly selects via an open or save panel. This is the most common file entitlement and covers the majority of document-based app workflows.

`com.apple.security.files.downloads.read-write` grants access to the Downloads folder without requiring the user to select files manually.

### Hardened Runtime Exceptions

Hardened runtime entitlements relax specific restrictions imposed by the hardened runtime. They should be used sparingly, each one weakens the security boundary the hardened runtime provides.

`com.apple.security.cs.disable-library-validation` allows loading frameworks and dynamic libraries that are not signed by Apple or the same team as the app. Required when bundling third-party frameworks that are signed by a different team.

### App Groups

`com.apple.security.application-groups` allows sharing a container directory between the main app and its extensions like share extensions, notification content extensions, and similar targets. All targets sharing the group must declare the same group identifier and be signed by the same team.

## Sandbox Container

A sandboxed app's container is located at:

```bash
~/Library/Containers/com.example.MyApp/
```

This directory is the app's home, `NSHomeDirectory()` returns it when called from a sandboxed process. Files written to `~/Documents` from within a sandboxed app actually go to `~/Library/Containers/com.example.MyApp/Data/Documents/`.

## Temporary Exception Entitlements

For Mac App Store review, Apple occasionally grants temporary exception entitlements that allow access beyond normal sandbox boundaries. These are prefixed with `com.apple.security.temporary-exception` and require justification during App Store review. They are intended as a transitional measure while an app migrates to a fully sandboxed architecture.

## Checking Entitlements

The entitlements embedded in a signed binary can be inspected with `codesign`:

```bash
# Read entitlements from a signed app
codesign -d --entitlements :- /Applications/Biolume.app

# Verify the signature and entitlements together
codesign --verify --verbose /Applications/Biolume.app
```

# Permission Request App

## Project

The sample app is in [`PermissionsExplorer`](../../assets/PermissionsExplorer).

## What the App Does

A minimal macOS app demonstrating how to request and display the status of two TCC-protected resources, Camera and Microphone, using `AVFoundation`. The app shows the current authorization status for each permission and provides a button to trigger the system permission prompt. The button disables itself once a decision has been made, since TCC decisions are permanent until the user manually resets them in System Settings.

## Implementation

Permission requests use `AVCaptureDevice.requestAccess(for:)` which presents the system TCC prompt on first call and returns the cached decision on subsequent calls. The completion handler runs on an arbitrary background thread, so all UI state updates are dispatched back to the main thread explicitly.

Authorization status is modeled with `AVAuthorizationStatus` which has four cases: `notDetermined`, `authorized`, `denied`, and `restricted`. The `@unknown default` case is handled to satisfy the compiler's exhaustive switch requirement for future-proofed enums.

## Purpose Strings

Attempting to access a TCC-protected resource without a corresponding purpose string in `Info.plist` causes an immediate crash, not a graceful denial. This is enforced regardless of whether the capability is enabled in the Hardened Runtime or App Sandbox entitlements. The entitlements declare intent to the sandbox, but the purpose string is what TCC uses to populate the permission prompt shown to the user. Both are required independently.

```xml
<key>NSCameraUsageDescription</key>
<string>This app demonstrates macOS camera permission requests.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app demonstrates macOS microphone permission requests.</string>
```

## Screenshots

|                                                           Crash without purpose string                                                           |                                   Initial app state                                    |
| :----------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------: |
|                                   ![Crash](../../assets/images/Screenshot%202026-06-07%20at%204.28.10 PM.png)                                    | ![Initial State](../../assets/images/Screenshot%202026-06-07%20at%204.53.38 PM%20.png) |
| *Immediate crash when `NSCameraUsageDescription` is missing from `Info.plist`, despite camera being enabled in Hardened Runtime and App Sandbox* |       *App on first launch showing "Not Determined" status for both permissions*       |

|                              Camera permission prompt                               |                           Microphone permission prompt                           |
| :---------------------------------------------------------------------------------: | :------------------------------------------------------------------------------: |
| ![Camera Prompt](../../assets/images/Screenshot%202026-06-07%20at%204.54.04 PM.png) | ![Mic Prompt](../../assets/images/Screenshot%202026-06-07%20at%204.54.16 PM.png) |
|                        *System TCC prompt for camera access*                        |                    *System TCC prompt for microphone access*                     |

|                                                 Authorized state                                                 |
| :--------------------------------------------------------------------------------------------------------------: |
|                 ![Authorized](../../assets/images/Screenshot%202026-06-07%20at%204.54.22 PM.png)                 |
| *Both permissions granted and buttons disabled since TCC decisions are permanent until reset in System Settings* |

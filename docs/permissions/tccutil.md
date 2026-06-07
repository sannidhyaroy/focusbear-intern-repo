# TCC Debugging with `tccutil`

## What is `tccutil`?

> For a structural understanding of how the Transparency, Consent, and Control (TCC) daemon intercepts hardware requests, enforces kernel-level boundaries, and utilizes SQLite databases, refer to [`tcc`](./tcc.md).

`tccutil` is a native macOS command-line utility used to manage the Transparency, Consent, and Control (TCC) privacy database. During development, testing permission flows requires simulating a fresh application install where the user has not yet responded to privacy prompts. Because TCC caches user decisions permanently, deleting the application bundle or rebuilding the binary does not reset its permissions. `tccutil` solves this by modifying the TCC database directly, allowing developers to reset permission states for specific subsystems or bundles without modifying the global system privacy settings.

## Mechanics of TCC Tracking

The TCC daemon tracks privacy permissions using the application’s unique **Bundle Identifier** (e.g., `com.thenoton.PermissionsExplorer`). TCC maps this identifier to specific hardware and software subsystems.

When an app is signed with a development certificate, modifying the code structure or entitlements without changing the bundle identifier can sometimes cause TCC verification to fail silently. In these instances, resetting the specific service via the command line forces the operating system to clear the cached state, ensuring the system privacy prompt displays correctly on the next API call.

## Using `tccutil` to Reset Permissions

The syntax for resetting permissions requires specifying the command (`reset`), followed by the TCC service identifier, and optionally the bundle identifier of the target application.

```bash
tccutil reset [Service_Identifier] [Bundle_Identifier]
```

If the bundle identifier is omitted, the specified permission is reset globally for all applications on the system.

### Core Reset Commands for Hardware & Automation

| Service / Resource     | Command                                                        | Description                                                                                                                                                        |
| ---------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Camera**             | `tccutil reset Camera com.thenoton.PermissionsExplorer`        | Resets the camera permission state, forcing a new prompt upon the next `AVCaptureDevice.requestAccess(for: .video)` invocation.                                    |
| **Microphone**         | `tccutil reset Microphone com.thenoton.PermissionsExplorer`    | Resets the microphone permission state, testing the fallback or initialization code path for `AVCaptureDevice.requestAccess(for: .audio)`.                         |
| **Accessibility (AX)** | `tccutil reset Accessibility com.thenoton.PermissionsExplorer` | Removes the application from the Accessibility list in System Settings. Essential for testing whether `AXIsProcessTrustedWithOptions` correctly registers the app. |
| **All Services**       | `tccutil reset All com.thenoton.PermissionsExplorer`           | Wipes the entire TCC database history for the specified bundle ID, reverting all system permissions back to their default unprompted state.                        |

### Additional Developer Environment Commands

During deeper systems development or automation testing, you may need to reset wider permissions that impact helper tools or build environments:

- **System Policy (All Files):** Resets Full Disk Access permissions.

    ```bash
    tccutil reset SystemPolicyAllFiles com.thenoton.PermissionsExplorer
    ```

- **Developer Tools:** Resets the permission that allows terminal utilities or IDEs to run binaries that don't meet standard system security policies.

    ```bash
    tccutil reset DeveloperTools com.thenoton.PermissionsExplorer
    ```

## Debugging Pitfalls & Edge Cases

- **TCC Reset Failures:** Executing `tccutil` requires appropriate privileges. If a reset command fails or fails to alter the application state, ensure the bundle identifier matches the target precisely by inspecting the application's built `Info.plist`.
- **Sub-process Inheritance:** If your application spawns an unbundled helper executable via `Process` or `posix_spawn`, the helper process typically inherits the TCC context of the parent application bundle. Resetting the parent bundle identifier resets the child process permissions simultaneously.
- **System Policy Control:** `tccutil` can only modify the user-level TCC database. It cannot bypass or programmatically *grant* permissions without user intervention; it can only reset them to `notDetermined`.

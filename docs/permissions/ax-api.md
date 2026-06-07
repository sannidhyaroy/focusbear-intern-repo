# Accessibility APIs

## What are Accessibility APIs?

The macOS Accessibility API (AX API) allows applications to inspect and interact with the UI elements of other running applications programmatically. It is built on top of the Assistive Technology Service Provider Interface (AT-SPI) and exposed through the `AXUIElement` family of C APIs in the `ApplicationServices` framework.

Common use cases include screen readers, automation tools, window managers, and productivity apps that need to read or control other applications. Focus Bear uses the Accessibility API to detect which app is currently in focus and enforce blocking during focus sessions.

## TCC Requirement

Accessibility API access requires the user to grant Accessibility permission in `System Settings > Privacy and Security > Accessibility`. This is one of the most powerful TCC permissions, an app with Accessibility access can read and manipulate the UI of any other running application. The permission prompt cannot be triggered programmatically like camera or microphone. The user must manually add the app in System Settings.

Without Accessibility permission, AX API calls return `AXError.cannotComplete` or simply return no data silently depending on the call.

## Core Concepts

**AXUIElement:** an opaque reference to a UI element in another application. Every window, button, text field, menu item, and the application itself is an `AXUIElement`.

**AXAttribute:** a named property of an `AXUIElement`. Common attributes include `AXTitle`, `AXValue`, `AXRole`, `AXFocusedUIElement`, `AXWindows`, and `AXPosition`.

**AXAction:** an action that can be performed on an element, such as `AXPress` for buttons or `AXRaise` for windows.

## Code Snippet

```swift
import ApplicationServices
import AppKit

// Check if Accessibility permission is granted
func isAccessibilityGranted() -> Bool {
    return AXIsProcessTrusted()
}

// Prompt user to grant Accessibility permission if not already granted
func requestAccessibilityPermission() {
    let options: NSDictionary = [
        kAXTrustedCheckOptionPrompt.takeRetainedValue(): true
    ]
    AXIsProcessTrustedWithOptions(options)
}

// Get the focused application
func getFocusedApplication() -> String? {
    guard isAccessibilityGranted() else {
        print("Accessibility permission not granted")
        return nil
    }

    guard let frontApp = NSWorkspace.shared.frontmostApplication else {
        return nil
    }

    let pid = frontApp.processIdentifier
    let appElement = AXUIElementCreateApplication(pid)

    var focusedWindow: CFTypeRef?
    let result = AXUIElementCopyAttributeValue(appElement, kAXFocusedWindowAttribute as CFString, &focusedWindow)

    guard result == .success, let window = focusedWindow else {
        return frontApp.localizedName
    }

    var title: CFTypeRef?
    AXUIElementCopyAttributeValue(window as! AXUIElement, kAXTitleAttribute as CFString, &title)

    if let windowTitle = title as? String, !windowTitle.isEmpty {
        return "\(frontApp.localizedName ?? "Unknown") — \(windowTitle)"
    }

    return frontApp.localizedName
}

// Get all windows of the frontmost application
func getWindowsOfFrontmostApp() -> [String] {
    guard isAccessibilityGranted() else { return [] }

    guard let frontApp = NSWorkspace.shared.frontmostApplication else {
        return []
    }

    let pid = frontApp.processIdentifier
    let appElement = AXUIElementCreateApplication(pid)

    var windowList: CFTypeRef?
    let result = AXUIElementCopyAttributeValue(appElement, kAXWindowsAttribute as CFString, &windowList)

    guard result == .success,
          let windows = windowList as? [AXUIElement] else {
        return []
    }

    return windows.compactMap { window in
        var title: CFTypeRef?
        AXUIElementCopyAttributeValue(window, kAXTitleAttribute as CFString, &title)
        return title as? String
    }
}

// Example usage
if isAccessibilityGranted() {
    if let focused = getFocusedApplication() {
        print("Focused: \(focused)")
    }
    let windows = getWindowsOfFrontmostApp()
    windows.forEach { print("Window: \($0)") }
} else {
    requestAccessibilityPermission()
}
```

## Error Handling

AX API calls return `AXError` values rather than throwing Swift errors. The most common errors are:

**`AXError.success`:** the call succeeded.
**`AXError.cannotComplete`:** the app does not have Accessibility permission, or the target process is unresponsive.
**`AXError.noValue`:** the requested attribute exists but has no value for this element.
**`AXError.attributeUnsupported`:** the element does not support the requested attribute.
**`AXError.apiDisabled`:** Accessibility is disabled system-wide in System Settings.

## Observing Changes

Beyond reading attributes, the AX API supports observing changes via `AXObserver`. This allows an app to be notified when a focused element changes, a window is created or destroyed, or a value changes, without polling.

```swift
// Create an observer for the frontmost app
func createObserver(for pid: pid_t) {
    var observer: AXObserver?
    AXObserverCreate(pid, { _, element, notification, _ in
        print("Notification: \(notification)")
    }, &observer)

    guard let observer = observer else { return }

    let appElement = AXUIElementCreateApplication(pid)
    AXObserverAddNotification(observer, appElement, kAXFocusedWindowChangedNotification as CFString, nil)

    CFRunLoopAddSource(CFRunLoopGetMain(), AXObserverGetRunLoopSource(observer), .defaultMode)
}
```

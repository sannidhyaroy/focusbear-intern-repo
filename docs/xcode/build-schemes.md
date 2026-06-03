# Build Settings & Schemes

## Build Configurations

Xcode projects have two default build configurations:

**Debug** is used during development. The compiler optimizes minimally, preserving the structure of the code so the debugger can step through it accurately. Debug symbols are embedded in the binary, allowing LLDB to map machine instructions back to source lines. Assertions are active. The binary is larger and slower but fully inspectable.

**Release** is used for distribution. The compiler applies aggressive optimizations like inlining functions, eliminating dead code, reordering instructions. Debug symbols are stripped from the binary and optionally saved to a separate `dSYM` bundle for crash symbolication. Assertions are inactive. The binary is smaller, faster, and not debuggable in the traditional sense.

## Key Build Setting Differences

| Setting            | Debug           | Release                  |
| ------------------ | --------------- | ------------------------ |
| Optimization Level | None (`-Onone`) | Whole Module (`-O`)      |
| Debug Symbols      | Embedded        | Stripped, dSYM generated |
| Assertions         | Active          | Inactive                 |
| Swift Flags        | `DEBUG` defined | Not defined              |
| Bitcode            | Optional        | Required for App Store   |

## Schemes

A scheme defines what happens when you build, run, test, profile, analyze, or archive a target. It ties together a target, a build configuration, and a set of launch arguments and environment variables.

The scheme selector in the Xcode toolbar shows the active scheme and the destination (device or simulator). Manage schemes via `Product > Scheme > Edit Scheme` to configure actions, or `Product > Scheme > Manage Schemes` to add, delete, and mark schemes as shared for source control.

### Scheme Actions

Each scheme has six actions, each independently configurable:

- **Build:** Which targets to build and in what order.
- **Run:** Which build configuration to use, launch arguments, environment variables, and diagnostics like the Address Sanitizer and Thread Sanitizer.
- **Test:** Which test targets to include, code coverage settings, and test randomization.
- **Profile:** Which build configuration to use when launching Instruments. Defaults to Release to profile optimized code.
- **Analyze:** Runs the Clang static analyzer to find logic errors and memory issues without running the code.
- **Archive:** Which build configuration to use when creating a distributable build. Defaults to Release.

## Conditional Compilation

The `DEBUG` flag defined in the Debug configuration enables conditional compilation:

```swift
#if DEBUG
print("Debug mode: verbose logging active")
let apiBaseURL = "https://staging.api.example.com"
#else
let apiBaseURL = "https://api.example.com"
#endif
```

This is the standard pattern for pointing debug builds at staging environments and release builds at production, or for enabling verbose logging only in development.

## `dSYM` Files

When the Release configuration strips debug symbols from the binary, Xcode generates a `dSYM` bundle alongside the archive. When a crash report arrives from a user, the `dSYM` is used to symbolicate the raw memory addresses in the crash log back into readable function names and line numbers. Without the `dSYM` from the exact build that crashed, the crash report is unreadable.

For Sparkle-distributed apps outside the App Store, storing `dSYM` files alongside each release build is essential for debugging production crashes.
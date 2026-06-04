# Debugging Tools

## Breakpoints

Breakpoints pause execution at a specific line, allowing inspection of program state at that exact moment. Set a breakpoint by clicking the line number gutter in the editor, a blue arrow appears. Click it again to disable without deleting. Right-click for options including conditional breakpoints and actions.

### Breakpoint Types

**Line breakpoint:** Pauses at a specific line. The most common type.

**Conditional breakpoint:** Pauses only when a condition is true, such as `index == 5` or `user == nil`. Right-click a breakpoint and set the condition to avoid stepping through hundreds of iterations manually.

**Symbolic breakpoint:** Pauses whenever a named function or method is called, regardless of which file it is in. Useful for intercepting system framework calls like `viewDidLoad` across all view controllers without setting individual breakpoints.

**Exception breakpoint:** Pauses when an exception is thrown, before the crash, giving full stack context. Add via the Breakpoint Navigator `+` button. Essential for debugging crashes.

**Runtime issue breakpoint:** Pauses on runtime warnings like main thread checker violations and memory graph issues.

## LLDB

LLDB is the debugger that Xcode uses under the hood. The console at the bottom of the debug area accepts LLDB commands directly while paused at a breakpoint.

### Useful Commands

- `po <expression>`: print object description. Calls the object's `debugDescription`. Works on any Swift or Objective-C object.
- `p <expression>`: print value. Lower level than `po`, shows type information alongside the value.
- `bt`: backtrace. Prints the full call stack at the current pause point, showing every frame from the current function back to the appentry point.
- `frame select <n>`: jump to a specific frame in the backtrace to inspect variables at that level of the call stack.
- `expr <statement>`: evaluate and execute a Swift expression in the current context. Can modify variables, call functions, or even injectnew code at runtime.
- `continue` or `c`: resume execution until the next breakpoint.
- `next` or `n`: step over the current line, executing it without entering any function calls.
- `step` or `s`: step into the current line, entering any function calls.
- `finish`: step out of the current function and pause at the return site.

## Debug Navigator

The Debug Navigator shows live CPU, memory, disk, and network usage graphs during an active debug session. Clicking any graph opens a more detailed view. The memory graph is the first place to look when investigating leaks or unexpectedly high memory usage.

## View Hierarchy Debugger

`Debug > View Debugging > Capture View Hierarchy` pauses the app and renders a 3D exploded view of the entire view hierarchy. Every layer is individually selectable and inspectable. Invaluable for diagnosing layout issues, hidden views, and constraint conflicts that are not visible in the flat 2D interface.

## Screenshots

|                                  **Breakpoint**                                   |                                       **Variables View**                                        |                                  **LLDB Usage**                                  |
| :-------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------: |
| ![Breakpoints](../../assets/images/Screenshot%202026-06-03%20at%202.24.22 PM.png) |      ![Debug Variables](../../assets/images/Screenshot%202026-06-03%20at%202.33.03 PM.png)      | ![LLDB Usage](../../assets/images/Screenshot%202026-06-03%20at%202.34.50 PM.png) |
|                           *Breakpoint set in Line 1169*                           | *Xcode's Debug Area showing Variables View on the left side and LLDB Console on the right side* |                 *LLDB Console showing `p self` and `bt` output*                  |

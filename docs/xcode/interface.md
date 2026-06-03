# Xcode Interface Exploration

## The Xcode Workspace

Xcode's interface is organized into four main areas around a central editor.

## Navigator (Left Panel)

The leftmost panel, toggled with **`⌘ + 0`**. Contains multiple navigators accessible via the icons at the top:

- **Project Navigator (`⌘ + 1`):** The File Tree. Primary way to navigate source files, assets, and resources in the project.
- **Source Control Navigator (`⌘ + 2`):** Git Status, Branches, and Commit History without leaving Xcode.
- **Symbol Navigator (`⌘ + 3`):** Browse all classes, structs, protocols, and functions across the project. Useful for large codebases.
- **Find Navigator (`⌘ + 4`):** Project-wide Search with support for regular expressions, case sensitivity, and scope filtering.
- **Issue Navigator (`⌘ + 5`):** All compiler errors, warnings, and static analysis results in one place.
- **Test Navigator (`⌘ + 6`):** Run individual or grouped tests, see pass/fail status per test.
- **Debug Navigator (`⌘ + 7`):** CPU, memory, disk, and network usage graphs during an active debug session.
- **Breakpoint Navigator (`⌘ + 8`):** Manage all breakpoints across the project, including conditional breakpoints and symbolic breakpoints.
- **Report Navigator (`⌘ + 9`):** Build logs, test results, and code coverage reports.

## Editor (Center)

The main working area. Supports several modes:

- **Standard Editor:** Single file view
- **Assistant Editor (`⌃ + ⌥ + ⌘ + ⏎`):** Split view showing a related file alongside the current one. Commonly used to show a SwiftUI preview next to the source, or a header next to an implementation.
- **Version Editor:** Side by side diff against git history

The jump bar at the top of the editor shows the full file path and allows navigating to any symbol in the current file via `⌃ + 6`.

## Inspector (Right Panel)

Toggled with `⌘ + ⌥ + 0`. Context-sensitive, hence content changes depending on what is selected:

- **File Inspector:** File metadata, target membership, and localization settings for the selected file.
- **History Inspector:** Git history for the current file.
- **Quick Help Inspector:** Inline documentation for the selected symbol, same content as `⌥ + click`.
- **Attributes Inspector:** When a view is selected in Interface Builder, shows visual properties like background color, font, and constraints.
- **Size Inspector:** Position, size, and Auto Layout constraints for selected Interface Builder elements.
- **Connections Inspector:** IBOutlets and IBActions connected to the selected Interface Builder element.

## Debug Area (Bottom Panel)

Toggled with `⌘ + ⇧ + Y`. Appears during active debug sessions and contains two panes:

- **Variables View (left):** All variables in the current scope with their values. Supports po (print object) and custom data formatters.
- **Console (right):** Standard output, print statements, and the LLDB debugger prompt. LLDB commands like `po`, `p`, `bt` (backtrace), and `frame select` are entered here.

## Toolbar

The top bar contains the scheme selector (which target to build and which device or simulator to run on), the run and stop buttons, and the activity viewer showing build progress and status messages.

## Key Shortcuts Worth Knowing

| Action             | Shortcut    |
| ------------------ | ----------- |
| Build              | `⌘ + B`     |
| Run                | `⌘ + R`     |
| Test               | `⌘ + U`     |
| Clean build folder | `⌘ + ⇧ + K` |
| Open quickly       | `⌘ + ⇧ + O` |
| Jump to definition | `⌘ + click` |
| Show documentation | `⌥ + click` |
| Toggle navigator   | `⌘ + 0`     |
| Toggle inspector   | `⌘ + ⌥ + 0` |
| Toggle debug area  | `⌘ + ⇧ + Y` |

# Activity Monitor

## What is Activity Monitor?

Activity Monitor is macOS's built-in task manager and system resource viewer. It provides real-time visibility into CPU, memory, energy, disk, and network usage across all running processes. It is the first place to look when something feels wrong, slow, hot, draining battery, or unresponsive.

## Debug Use Cases

### CPU Tab

- **Identifying runaway processes:** Sort by `% CPU` descending. A process at 90-100% CPU when it should be idle is the first signal of a bug, an infinite loop, a leaked timer, or a callback firing continuously. This is different from a process doing legitimate heavy work, which will show high CPU briefly then settle.

- **Checking main thread vs background threads:** Double-clicking a process opens a detailed view showing individual threads and their CPU usage. A UI freeze with high CPU on the main thread means work that should be offloaded to a background thread is blocking the run loop. A UI freeze with low overall CPU usually means the main thread is waiting on a lock or a synchronous network call.

- **Identifying CPU regressions after updates:** If an app starts consuming more CPU after an update, Activity Monitor lets you confirm the regression and quantify it before filing a bug report. Sort by CPU, note the baseline, update, and compare.

### Memory Tab

- **Identifying memory leaks:** A process whose memory usage grows continuously without plateauing is leaking memory. Memory leaks occur when a program allocates memory but never releases it, the allocation accumulates until the system runs out of available memory or the app crashes. The characteristic pattern in Activity Monitor is a sawtooth graph, memory climbs steadily, the system occasionally reclaims some, then it climbs again. SwiftUI's `TimelineView` exhibits this pattern (from my own experience, observed on March 2026) when used with a 60fps schedule and it leaks attribute-graph nodes on every evaluation, producing 0.3–1.5 MB/s of unbounded growth that is visible in Activity Monitor (and, Xcode Debug Gauges) over time.

- **Memory pressure graph:** The graph at the bottom of the Memory tab is the most actionable signal on memory-constrained machines. Green means the system has headroom. Yellow means macOS is actively compressing memory pages and performance is degrading. Red means the system is writing memory to disk (swap), at this point the machine will feel noticeably slow and any further memory allocation will make things worse. On an base memory machines (like MacBooks with 8GB of Unified Memory), this graph is worth keeping an eye on when running multiple heavy applications simultaneously.

- **Checking swap usage:** Visible at the bottom of the Memory tab under "Swap Used". Persistent swap usage on is a real constraint that directly affects architecture decisions. For example, an app that spawns multiple WebView instances each holding their full loaded state in memory will push an 8GB machine into swap much faster than one using a shared WebView with navigation.

- **Real Size vs Virtual Memory:** The "Real Memory" column shows actual RAM usage. "Virtual Memory" includes mapped files and shared libraries and is almost always much larger, so don't be alarmed by a 2GB virtual memory figure on a process using 50MB of real memory.

### Energy Tab

- **Identifying battery drain culprits:** Sort by Energy Impact. An app showing high energy impact when it should be idle is doing unnecessary background work like polling a server, running timers, or preventing App Nap from activating.

- **App Nap:** macOS throttles background apps that are not visible and not doing user-requested work. The "Preventing Sleep" and "App Nap" columns show whether a process is exempt from throttling. If a background task stops running unexpectedly, check whether App Nap is activated. The app may need to use a background task assertion to prevent it.

- **12-Hour Power column:** Shows average energy impact over the past 12 hours. More useful than the instantaneous Energy Impact column for identifying apps that drain battery over time rather than in bursts.

### Disk Tab

- **Identifying I/O bottlenecks:** Sort by `Bytes Written` descending. A process writing gigabytes to disk unexpectedly is either logging excessively, writing large caches, or has a bug causing redundant writes. High disk I/O from a database process during heavy use is expected, the same from a UI process is not.

- **Diagnosing slow app launch:** High disk reads during app launch indicate the app is loading large resources from disk on startup. This is a performance optimization opportunity, resources can be lazy-loaded or cached after first launch.

### Network Tab

- **Identifying unexpected network activity:** Sort by `Bytes Sent` or `Bytes Received`. An app sending data when the user is not actively using it warrants investigation, it may be syncing in the background (expected), phoning home with telemetry (possibly unwanted), or indicating a misconfigured retry loop hitting an API endpoint repeatedly.

- **Debugging connection counts:** Double-clicking a process and opening the "Open Files and Ports" panel shows every active file descriptor and network connection. This is useful for confirming whether an app is maintaining too many simultaneous connections. A WebSocket-heavy app like a real-time sync client can open hundreds of connections that are visible here.

### Process Inspection

- **Sampling a process:** `View > Sample Process` captures a statistical stack trace of a running process over a few seconds. It shows which call stacks are active most frequently, the closest thing to a free profiler without attaching Instruments. Useful for diagnosing a hang or a CPU spike without interrupting the process.

- **Spindump:** For a completely unresponsive process, Activity Monitor can generate a spindump, a snapshot of every thread's call stack at the moment of the hang. This is often the first artifact requested by Apple engineers when filing a bug report about a system-level hang.

- **Force Quit:** The `X` button in Activity Monitor is more reliable than the Dock's Force Quit for killing truly frozen processes, since it sends `SIGKILL` directly rather than going through the normal quit path that a frozen process cannot respond to.

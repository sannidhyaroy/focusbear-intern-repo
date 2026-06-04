# Instruments: CPU & Memory

## What is Instruments?

Instruments is Apple's performance analysis and testing tool, bundled with Xcode. It attaches to a running process and records detailed telemetry over time. Accessible via `Xcode > Open Developer Tool > Instruments` or `⌘ + I` to profile the current scheme directly.

## Key Instruments

### Time Profiler

Records CPU usage by sampling the call stack at regular intervals (typically 1ms). The result is a flame graph showing which functions consumed the most CPU time. Heavy functions appear wider. Drilling down shows the exact call chain responsible for the CPU usage.

Use when the app feels slow, a UI interaction is janky, or a background operation is taking longer than expected.

### Allocations

Tracks every memory allocation and deallocation over time. Shows the total heap size, allocation count, and a breakdown by object type. The "Generation" feature takes snapshots at intervals and shows what was allocated between snapshots, making it easy to identify objects that are created but never released.

Use when memory usage grows unexpectedly or the app is using more RAM than it should.

### Leaks

Detects retain cycles and abandoned memory. Runs automatically alongside Allocations. When a leak is detected, Instruments shows the object graph that is keeping the leaked object alive, including the reference chain responsible for the cycle.

Use when Xcode Memory Graph Debugger shows a sawtooth memory growth pattern.

### VM Tracker

Shows virtual memory usage broken down by region type: heap, stack, mapped files, and frameworks. Useful for understanding the full memory footprint beyond just heap allocations.

### Network

Records all network requests made by the app, including URL, response code, bytes transferred, and timing. Useful for identifying redundant requests, large payloads, and slow endpoints.

## Profiling Summary

Instruments was run on a [macOS app](https://github.com/sannidhyaroy/Soduto) using the Time Profiler and Allocations instruments.

### Time Profiler Findings

The heaviest CPU consumer was the main thread, accounting for 53.1% of total CPU time (894ms of 1.68s). The call tree traced through `NSApplication`'s event loop into Preferences initialization (`specialized static Pref...`, 206ms), triggered by the first access of a lazy-initialized view controller. Two hangs were recorded by the Hangs instrument, visible as amber markers in the timeline, corresponding to the main thread being blocked during this initialization and a subsequent device connection event.

### Allocations Findings

Heap usage stabilized at approximately 12.46 MiB of persistent heap allocations across 80,258 objects, with a total of 149.74 MiB allocated over the 33-second session (including transient objects). Anonymous VM brought the total persistent footprint to 29.32 MiB. No unexpected growth was observed, the allocation graph shows activity during app initialization followed by a flat line, indicating normal behavior with no memory leaks or runaway allocations during the observation period.

## Screenshots

|                                   *Time Profiler*                                   |                                   *Allocations*                                   |
| :---------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------: |
| ![Time Profiler](../../assets/images/Screenshot%202026-06-03%20at%204.08.51 PM.png) | ![Allocations](../../assets/images/Screenshot%202026-06-03%20at%204.27.33 PM.png) |
|      *Instruments app profiling a macOS app using the Time Profiler template*       |      *Instruments app profiling a macOS app using the Allocations template*       |

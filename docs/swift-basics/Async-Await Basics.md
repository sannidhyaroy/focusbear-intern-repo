# Async/Await Basics

## Playground Demo

The full demo is in [`Async-Await Basics.playground`](../../assets/Async-Await%20Basics.playground).

## Key Concepts

### `async`/`await`

Functions marked `async` can suspend their execution without blocking the thread. `await` marks a suspension point where the function may pause while waiting for an asynchronous result. This replaces completion handler callbacks with linear, readable code.

### `Task`

`Task {}` creates a new unit of asynchronous work. It is the entry point for async code from a synchronous context. Tasks run concurrently with the code that creates them and can be cancelled.

### `async let`

Starts an async operation immediately without waiting for its result. Multiple `async let` bindings run in parallel. The `await` happens later when the results are actually needed, allowing concurrent execution with minimal code.

### Task Groups

`withThrowingTaskGroup` creates a dynamic number of concurrent tasks and collects their results. Used when the number of parallel operations is not known at compile time, such as fetching data for each item in an array.

### Actors

An actor protects shared mutable state from data races by serializing access. Only one task can access an actor's state at a time. Accessing an actor's properties or methods from outside requires `await`, making the potential for suspension explicit.

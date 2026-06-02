# Optionals & Unwrapping

## Playground Demo

The full demo is in [`Optionals & Unwrapping.playground`](../../assets/Optionals%20&%20Unwrapping.playground).

## Key Concepts

### Why Optionals Exist

In Swift, a variable cannot hold `nil` unless explicitly declared as optional. This makes the absence of a value explicit and compiler-enforced, eliminating an entire class of null pointer crashes that are common in Objective-C and other languages.

### `if let`

Safely unwraps an optional. The unwrapped value is only available inside the `if` block. Multiple optionals can be unwrapped in a single `if let` chain, and all must be non-nil for the block to execute.

### `guard let`

Unwraps an optional with an early exit. The unwrapped value is available in the enclosing scope after the guard statement, not inside a nested block. This is the preferred pattern for validating preconditions at the top of a function, keeping the happy path unindented.

### Optional Chaining

Accessing properties or methods on an optional using `?.`. If the optional is nil, the entire chain short-circuits and returns nil. This replaces deeply nested if-let checks when accessing multiple optional layers.

### Nil Coalescing

The `??` operator provides a default value when an optional is nil. It is a concise alternative to an if-else check and reads naturally as "use this value, or fall back to that."

### `try?`

Converts a throwing expression into an optional. If the expression throws, the result is nil instead of propagating the error. Useful when the error details do not matter and a nil result is an acceptable fallback.

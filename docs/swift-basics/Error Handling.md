# Error Handling

## Playground Demo

The full demo is in [`Error Handling.playground`](../../assets/Error%20Handling.playground).

## Key Concepts

### Custom Error Types

Swift errors conform to the `Error` protocol. Enums are the idiomatic choice because each case can represent a distinct failure mode with associated values for additional context.

### `throws` and `try`

A function marked `throws` can throw an error. Calling it requires `try`, which makes the potential for failure visible at every call site. This is a compile-time enforcement, you cannot accidentally ignore a throwing call.

### `do`/`catch`

The primary mechanism for handling errors. Multiple `catch` clauses can match specific error cases, allowing different recovery strategies per failure mode. A catch-all clause handles anything not matched by earlier clauses.

### `try?`

Converts a throwing expression to an optional. Errors are silently discarded and the result is nil on failure. Use when failure details do not matter.

### `try!`

Force-tries a throwing expression and crashes if it throws. Only appropriate when the call is provably infallible, for example, compiling a regex from a string literal that is known to be valid.

### `rethrows`

A function that accepts a throwing closure and only throws if the closure throws. This allows higher-order functions like `map` to be non-throwing when used with non-throwing closures.

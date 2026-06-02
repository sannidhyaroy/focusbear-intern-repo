# Variables, Constants & Data Types

## Playground Demo

The full demo is in [`Variables, Constants & Data Types.playground`](../../assets/Variables,%20Constants%20&%20Data%20Types.playground).

## Key Concepts

### Constants and Variables

`let` declares a constant (immutable after declaration). `var` declares a variable (mutable). `let` is preferred wherever possible and the compiler warns if a `var` is never mutated.

### Type Inference

Swift infers types from context. Explicit annotation is optional but useful for clarity or when the inferred type is not what you want. `9.5` infers as `Double`, not `Float`, worth knowing since Float vs Double is a common source of subtle bugs.

### Optionals

A core Swift concept, a value that may or may not exist, represented with `?`. Optionals must be unwrapped before use. Safe unwrapping with `if let` or `guard let` is preferred over force unwrapping (`!`) which crashes if the value is nil.

### Type Safety

Swift is strongly typed. Conversion between types must always be explicit, there is no implicit numeric promotion. This eliminates an entire class of bugs common in weakly typed languages.

### Collections

Swift has three primary collection types: `Array` (ordered), `Dictionary` (key-value), `Set` (unordered, unique), and Tuple (group of related values). All are generic and typed, so a `[String]` array cannot accidentally contain an `Int`.

### Type Aliases

`typealias` gives an existing type a more expressive name without introducing a new type. Useful for making intent clear in APIs and completion handlers.

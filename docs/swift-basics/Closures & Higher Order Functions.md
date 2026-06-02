# Closures & Higher Order Functions

## Playground Demo

The full demo is in [`Closures & Higher Order Functions.playground`](../../assets/Closures%20&%20Higher%20Order%20Functions.playground).

## Key Concepts

### Closures

Closures are self-contained blocks of functionality that can be stored in variables, passed as arguments, and returned from functions. They capture values from their surrounding context.

### Syntax Progression

Swift allows progressively shorter closure syntax. The full form specifies parameter types, return type, and uses the `in` keyword. Shorthand argument names (`$0`, `$1`) eliminate the need to name parameters. Trailing closure syntax moves the closure outside the parentheses when it is the last argument.

### `map`

Transforms each element of a collection using a closure, returning a new collection of the same length with the transformed values.

### `filter`

Returns a new collection containing only the elements for which the closure returns true.

### `reduce`

Combines all elements of a collection into a single value using a closure, starting from an initial value.

### `compactMap`

Like `map`, but automatically unwraps optionals and removes nil results. Useful for transformations that may fail, like parsing strings to integers.

### `@escaping`

A closure marked `@escaping` outlives the function call it was passed to. This is required when storing a closure as a property or dispatching it asynchronously. The compiler enforces this distinction.

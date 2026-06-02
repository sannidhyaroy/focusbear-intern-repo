# Generics

## Playground Demo

The full demo is in [`Generics.playground`](../../assets/Generics.playground).

## Key Concepts

### What Generics Solve

Generics allow writing flexible, reusable code that works with any type while maintaining type safety. Without generics, you would either duplicate code for each type or lose type safety by using `Any`.

### Generic Functions

A generic function uses a type parameter (conventionally `T`) as a placeholder for the actual type, which is determined at the call site. The compiler generates specialized versions for each concrete type used.

### Generic Types

Structs, classes, and enums can be generic. A `Stack<Element>` works identically whether the element type is `Int`, `String`, or any other type, with full type safety enforced at compile time.

### Type Constraints

The `where` clause and protocol constraints restrict which types a generic can accept. `T: Comparable` means the generic only accepts types that implement comparison, enabling operations like `max()` that require ordering.

### Associated Types

Protocols can declare associated types using `associatedtype`. This allows protocols to express generic requirements without knowing the concrete type upfront, enabling powerful abstractions like `Collection`.

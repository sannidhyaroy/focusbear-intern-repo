# Protocols & Extensions

## Playground Demo

The full demo is in [`Protocols & Extensions.playground`](../../assets/Protocols%20&%20Extensions.playground).

## Key Concepts

### Protocols

A protocol defines a contract, a set of properties and methods that a conforming type must implement. Protocols are the foundation of protocol-oriented programming in Swift, enabling polymorphism without inheritance.

### Default Implementations

Extensions on a protocol can provide default implementations of its methods. Conforming types can use the default or override it. This allows shared behavior to be distributed without a base class, which is how SwiftUI's `View` protocol provides default behavior across all views.

### Protocol Composition

A type can conform to multiple protocols simultaneously using `&`. `typealias` can name a composition for reuse. This is the Swift alternative to multiple inheritance.

### Extensions on Existing Types

Extensions add methods, computed properties, and protocol conformances to any existing type, including types from the standard library or third-party frameworks, without subclassing or modifying the original source.

### Protocols as Types

A protocol can be used as a type, allowing heterogeneous collections of conforming types. This is the primary mechanism for runtime polymorphism in Swift.

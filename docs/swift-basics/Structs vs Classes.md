# Structs vs Classes

## Playground Demo

The full demo is in [`Structs vs Classes.playground`](../../assets/Structs%20vs%20Classes.playground).

## Key Concepts

### Value Types vs Reference Types

This is the most important distinction in Swift. Structs are value types, assigning or passing a struct creates an independent copy. Classes are reference types, assigning or passing a class instance shares the same object in memory. Modifying one reference affects all others pointing to the same object.

### `mutating`

Struct methods cannot modify properties by default because structs are value types. The `mutating` keyword explicitly marks methods that modify the struct's state, making mutation opt-in and visible at the call site.

### Inheritance

Only classes support inheritance. Structs cannot inherit from other structs. If a type needs to be subclassed or needs polymorphic behavior through a class hierarchy, it must be a class. For protocol-oriented polymorphism, structs are preferred.

### `deinit`

Only classes have a deinitializer. `deinit` runs when the last reference to a class instance is released, making it useful for cleanup like closing file handles or network connections.

### When to Use Each

Prefer structs by default. Use classes when you need identity (two references pointing to the same object is meaningful), when you need inheritance, or when you are interfacing with Objective-C APIs that expect reference types. Apple's own frameworks have moved heavily toward structs and value types since SwiftUI.

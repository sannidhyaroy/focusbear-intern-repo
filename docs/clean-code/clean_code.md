# Clean Code Principles

## Understanding Clean Code Principles

Clean code is not just code that works, it is code that communicates clearly, changes safely, and does not surprise the people who read it later. It prioritizes human readability over machine execution, ensuring that future developers can work with the codebase efficiently. The following principles form the foundation of what clean code means in practice.

---

### Simplicity

Simple code does one thing and does it clearly. It has no unnecessary abstractions, no clever tricks that require mental gymnastics to understand, and no code that exists "just in case." The measure of simplicity is not the number of lines but the cognitive load required to understand what the code does.

The principle is sometimes stated as YAGNI (You Aren't Gonna Need It). Do not add complexity for features or flexibility that does not exist yet. Complexity added early tends to stay forever, even when the anticipated need never materialises.

Simple code is also easier to test, easier to debug, and easier to delete when requirements change.

---

### Readability

Code is read far more often than it is written. A function that takes thirty minutes to write might be read hundreds of times over the life of a project. Readable code respects the reader's time by making intent obvious without requiring them to trace execution mentally.

Readable code:
- Uses names that reveal intent (`getUserById` not `getU`, `isEligibleForDiscount` not `check`)
- Keeps functions short enough to fit on one screen
- Avoids comments that explain *what* the code does (the code should do that itself) and uses comments only to explain *why* when the reasoning is not obvious
- Structures logic so the happy path is clear and edge cases are handled explicitly

---

### Maintainability

Maintainable code anticipates change. Requirements change, bugs are found, and features are added, code that was written assuming it would never be touched again becomes the most painful code to work with.

Maintainability is achieved through:
- **Single Responsibility:** each function, class, or module does one thing
- **Low coupling:** components depend on each other as little as possible
- **High cohesion:** things that change together are grouped together
- **Meaningful abstractions:** the right level of abstraction makes changes local rather than requiring edits across the entire codebase

The test of maintainability is whether a developer unfamiliar with the code can understand, modify, and test it without introducing new bugs.

---

### Consistency

Consistency means following the conventions of the codebase, even when you personally disagree with them. A codebase where every developer applies their own style is harder to read than one with a consistent style you might not prefer, because inconsistency forces the reader to context-switch constantly.

Consistency applies to:
- Naming conventions (`camelCase` vs `snake_case`, noun vs verb naming)
- File and folder structure
- Error handling patterns
- How comments are written
- How tests are structured

Automated tools such as linters, formatters, style, etc. guides enforce consistency without
relying on human discipline. They are not optional in a team context.

---

### Efficiency

Efficient code performs well without being prematurely optimised. The classic principle is Knuth's: "premature optimisation is the root of all evil." Write clear, correct code first. Optimise only where profiling demonstrates an actual bottleneck.

Efficiency also means algorithmic efficiency, i.e, choosing the right data structure and algorithm for the problem rather than brute-forcing with O(n²) when O(n log n) exists. This is not premature optimisation; it is appropriate design.

The balance is: do not write obviously inefficient code, but do not sacrifice readability and maintainability for micro-optimisations that a compiler or runtime will likely handle anyway.

---

### DRY (Don't Repeat Yourself)

Every piece of knowledge should have a single, unambiguous representation in the codebase. When the same logic exists in multiple places, a change to that logic requires finding and updating every copy. And, missing one creates inconsistency and bugs.

DRY is not just about avoiding copy-pasted code. It applies to configuration, documentation, and data schemas too. If the same truth is expressed in two places, those two places will eventually disagree.

The remedy is abstraction, i.e, extracting the repeated logic into a function, module, or constant that is referenced rather than repeated. The abstraction should be meaningful though, as DRY taken too far produces over-engineered code that is hard to understand because everything is abstracted into indirection.

---

### KISS (Keep It Simple, Stupid)

KISS is related to Simplicity but more pointed. It is a reminder that clever solutions are usually worse than obvious ones. A solution that requires the reader to understand three design patterns, two abstractions, and a non-obvious side effect is not a good solution even if it works.

The KISS principle pushes back against the instinct to over-engineer. When two solutions solve the same problem, the simpler one is almost always preferable as it is easier to test, easier to debug, easier to explain, and easier to change.

KISS and DRY can tension with each other. Removing repetition sometimes requires abstraction that adds complexity. The right balance is to DRY up things that genuinely share the same concept, not just things that happen to look similar.

---

### The Boy Scout Rule

Leave the codebase cleaner than you found it. When working on a file, if you notice a small issue like a poorly named variable, a comment that no longer reflects the code, an unnecessary import, fix it as part of your change rather than ignoring it.

The Boy Scout Rule prevents gradual decay. No single developer introduces a mess deliberately, but small compromises accumulate over time until the codebase becomes difficult to work with. The rule distributes the maintenance burden across all contributors rather than letting it pile up into a dedicated "cleanup sprint" that never happens.

The scope matters as Boy Scout fixes should be small and focused. A Boy Scout refactor that touches fifty files is a risky change that belongs in its own PR, not tucked into a feature commit.

---

## Example: Messy Code vs Clean Code

### Messy Version

```swift
func p(_ u: [String: Any]) -> Bool {
    // check stuff
    if u["a"] != nil {
        if (u["b"] as? Int) != nil {
            if (u["b"] as! Int) >= 18 {
                if u["c"] != nil {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    return false
}
```

**Why this is difficult to read:**
- **`p`, `u`, `a`, `b`, `c`:** none of these names reveal what they represent
- Deeply nested `if` statements (four levels) force the reader to track multiple conditions simultaneously
- Force unwrapping (`as!`) on line 5 will crash at runtime if the cast fails, despite the optional check on line 4 already confirming it is non-nil. The optional check makes the force unwrap safe here but the pattern is dangerous and unclear
- The comment `// check stuff` adds no information
- The function name `p` gives no indication of what is being checked or returned

### Clean Version

```swift
func isEligibleUser(_ user: [String: Any]) -> Bool {
    guard let _ = user["name"],
          let age = user["age"] as? Int,
          let _ = user["email"] else {
        return false
    }
    return age >= 18
}
```

**Why this is cleaner:**
- `isEligibleUser` and `user` immediately communicate intent
- `name`, `age`, `email` are readable field names
- `guard` flattens the nesting, so the happy path is a single `return` at the end
- The safe cast (`as? Int`) with `guard` eliminates the force unwrap entirely
- The eligibility condition (`age >= 18`) is immediately visible instead of buried three levels deep
- No comments needed as the code reads as plain English
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

## Code Formatting & Style Guides

### Why is Code Formatting Important?

Code formatting is not about aesthetics, it is about reducing cognitive load. When formatting is inconsistent, the reader's brain spends energy parsing structure rather than understanding logic. Consistent formatting removes that friction entirely.

More practically, formatting inconsistency causes noise in diffs. When a developer reformats a file as part of a change, the diff becomes a wall of whitespace changes that obscure the actual logic change. Automated formatters eliminate this problem by making formatting decisions non-negotiable and deterministic, so the diff shows only what actually changed.

Formatting also enforces a shared standard in teams. Without it, code reviews devolve into style debates. With it, those debates happen once (when configuring the tool) and never again.

### The Airbnb JavaScript Style Guide

The [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript) is one of the most widely adopted JS style guides. It enforces opinionated but well-reasoned rules: `const`/`let` over `var`, single quotes, required semicolons, `===` over `==`, arrow functions over function expressions, and more.

The semicolon requirement is worth noting specifically. JavaScript has Automatic Semicolon Insertion (ASI) which makes semicolons technically optional, but ASI has edge cases that can introduce subtle bugs, particularly when a line starts with `[`, `(`, or a template literal. Airbnb requires semicolons to eliminate that ambiguity entirely, which is the safer choice.

### Tools: ESLint and Prettier

**Prettier** is an opinionated code formatter. It reformats code to a consistent style without caring about logic. It fixes indentation, line length, quote style, trailing commas, and spacing automatically.

**ESLint** is a linter. It catches logical and stylistic issues that a formatter cannot fix automatically, so things like using `==` instead of `===`, variable shadowing, unused variables, and `var` declarations.

The two tools are complementary. Prettier handles formatting, ESLint handles code quality. Running Prettier first and then ESLint is the standard workflow.

### What Issues Did the Linter Detect?

Running ESLint with the Airbnb config on a deliberately messy `main.js` produced **82 problems (75 errors, 7 warnings)**. The violations included:

- **`no-var`**: `var` used instead of `const` or `let` throughout
- **`quotes`**: double quotes used instead of required single quotes
- **`semicolons`**: missing semicolons on every statement
- **`indent`**: 4-space indentation instead of required 2-space
- **`eqeqeq`**: `==` used instead of `===`
- **`no-else-return`**: unnecessary `else` blocks after `return` statements
- **`prefer-arrow-callback`**: `function` expression in `setTimeout` instead of arrow function
- **`no-shadow`**: function parameter `isAdmin` shadowing outer `const isAdmin`
- **`no-console`**: `console.log` statements flagged as warnings

After running **Prettier**, formatting issues were automatically fixed down to
**27 problems**. After running **ESLint --fix**, mechanical fixes were applied, which further brought
down to **8 problems**. The remaining 2 errors required human judgment:

1. **Variable shadowing** (`no-shadow`): renamed the `isAdmin` parameter to
   `isAdminFlag` to eliminate the shadow
2. **Loose equality** (`eqeqeq`): changed `user.isAdmin == true` to
   `user.isAdmin === true`

The 6 remaining warnings are all `no-console` which are all intentional for this demo file.

### Did Formatting Make the Code Easier to Read?

Yes, it did make it significantly more readable. The Prettier pass alone transformed a wall of inconsistently
indented, quote-mixed, semicolon-free code into something structurally readable.
The ESLint fixes then addressed the logical issues, like the `==` vs `===` distinction
is not just style, it is correctness, since `==` performs type coercion that
`===` does not.

The most interesting part of the exercise was what the tools could not fix
automatically. Variable shadowing and loose equality both require understanding
intent, so the tool can flag them but cannot resolve them without knowing what the
correct behavior should be. That boundary between automated and human judgment
is where the real value of linting lies.

### Practical Task

|                                Setup & Installation                                |                           ESLint Violations (82 problems)                           |
| :--------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------: |
| ![ESLint Setup](../../assets/images/Screenshot%202026-05-26%20at%203.09.14 PM.png) | ![ESLint Errors](../../assets/images/CleanShot%202026-05-26%20at%2015.18.23@2x.png) |

|                                    Prettier Diff                                    |                   ESLint Violations (27 problems) after Prettier                    |
| :---------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------: |
| ![ESLint Errors](../../assets/images/CleanShot%202026-05-26%20at%2015.24.21@2x.png) | ![Prettier Diff](../../assets/images/Screenshot%202026-05-26%20at%203.28.03 PM.png) |

|                        After ESLint `--fix` (8 problems)                        |                                 Manual Fixes Diff                                  |                                    ESLint Results                                    |
| :-----------------------------------------------------------------------------: | :--------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------: |
| ![After Fix](../../assets/images/Screenshot%202026-05-26%20at%203.30.39 PM.png) | ![Manual Fixes](../../assets/images/Screenshot%202026-05-26%20at%208.50.18 PM.png) | ![After Prettier](../../assets/images/Screenshot%202026-05-26%20at%208.47.13 PM.png) |

## Naming Variables & Functions

### What Makes a Good Variable or Function Name?

A good name is one that makes the code read like prose, so the reader understands what something is or does without needing to trace its definition or read a comment explaining it.

**For variables:**
- Name what it represents, not what type it is (`userAge` not `ageInt`, `isEligible` not `boolFlag`)
- Use nouns for values, booleans prefixed with `is`, `has`, `can`, or `should`
- Avoid abbreviations unless they are universally understood (`id`, `url`, `http`)
- Length should be proportional to scope, so a loop counter can be `i`, but a variable used across a module should be fully descriptive

**For functions:**
- Name what it does, not how it does it
- Use verbs like `getUserById`, `calculateTotal`, `isEligibleForDiscount`, etc.
- A function named `data` or `process` or `handle` tells you nothing
- If you struggle to name a function, it is often doing too many things

**The newspaper test:** read only the name. Does it tell you what you need to know? If you need to read the implementation to understand what the name means, the name has failed.

### What Issues Arise from Poorly Named Variables?

Poor names are a form of technical debt that compounds over time:

- **Maintenance burden:** future developers (including yourself) must reverse-engineer intent from implementation rather than reading it directly
- **Bug introduction:** ambiguous names lead to wrong assumptions, like `data`, `temp`, `result`, `val` could mean anything, and the next developer may use them incorrectly
- **Review difficulty:** code reviewers cannot spot logic errors if they cannot quickly understand what each variable represents
- **Documentation rot:** comments written to compensate for bad names become outdated and misleading as code evolves, while good names are always accurate

The worst case is a name that is actively misleading, like a variable called
`userList` that contains a count, or `isActive` that actually stores a timestamp.
These are more dangerous than obviously bad names because they create false
confidence.

### Refactoring Example

**Before (unclear naming):**

```swift
func p(_ d: [String: Any], _ f: Bool) -> String? {
    let n = d["n"] as? String
    let a = d["a"] as? Int
    if let nm = n, let ag = a {
        if ag > 18 && f {
            return "Hello, \(nm)"
        }
    }
    return nil
}

let u: [String: Any] = ["n": "Sannidhya", "a": 22]
let r = p(u, true)
```

**After (clear naming):**

```swift
func buildGreeting(for user: [String: Any], isVerified: Bool) -> String? {
    guard let name = user["name"] as? String,
          let age = user["age"] as? Int else {
        return nil
    }
    guard age > 18 && isVerified else {
        return nil
    }
    return "Hello, \(name)"
}

let userData: [String: Any] = ["name": "Sannidhya", "age": 22]
let greeting = buildGreeting(for: userData, isVerified: true)
```

**What changed:**
- **`p` → `buildGreeting(for:isVerified:)`:** immediately communicates what the function produces and what it needs
- **`d` → `user`, `f` → `isVerified`:** parameters now describe their role
- **`n`, `a` → `name`, `age`:** single letter variables eliminated
- **`nm`, `ag` → `name`, `age`:** binding names match what they represent
- **`u` → `userData`, `r` → `greeting`:** call site is now self-documenting

The refactored version can be read aloud and understood. The original required tracing every single-letter variable to its usage before the logic became clear.

### How Did Refactoring Improve Readability?

The most significant improvement was at the call site. `p(u, true)` is completely opaque, so you cannot tell what `true` means without reading the function signature. `buildGreeting(for: userData, isVerified: true)` reads as a sentence. Swift's argument labels make this particularly powerful, but the principle applies in any language.

The secondary improvement was eliminating the cognitive load of tracking single-letter variables. In the original, every read of `nm` requires a mental lookup back to `let nm = n`. In the refactored version, `name` is always `name`.

Names are the primary documentation of code. Good names make comments unnecessary. Bad names make comments insufficient.

## Writing Small, Focused Functions

### Why is Breaking Down Functions Beneficial?

A function should do one thing. This is the Single Responsibility Principle applied at the function level. When a function does multiple things, every one of those things becomes harder to test, harder to reuse, harder to name, and harder to change without affecting everything else the function does.

Small, focused functions have several concrete advantages:

- **Testability:** a function that does one thing has one reason to fail. You can write a single focused test for it. A function that does five things requires tests that cover every combination of those five things.
- **Readability:** a well-named small function reads like documentation. A chain of well-named function calls tells a story, like `validateUser()`, `fetchUserData()`, `formatResponse()`, without requiring the reader to understand implementation details.
- **Reusability:** small functions can be composed. A large monolithic function cannot be partially reused, you take all of it or none of it.
- **Debuggability:** when something goes wrong, a stack trace of small named functions tells you exactly where the failure occurred. A stack trace pointing to a 200-line function tells you almost nothing.
- **Changeability:** a change to one responsibility does not require touching code for other responsibilities. Small functions have smaller blast radii.

The heuristic is: if you need a comment to explain what a block of code inside a function does, that block should be its own function with a name that replaces the comment.

### Refactoring Example

**Before (one large function doing everything):**

```swift
func processUserLogin(username: String, password: String) -> String {
    // Validate inputs
    if username.isEmpty || password.isEmpty {
        return "Error: fields cannot be empty"
    }
    if password.count < 8 {
        return "Error: password too short"
    }
    if !username.contains("@") {
        return "Error: invalid email format"
    }

    // Simulate fetching user from database
    let mockUsers = ["user@example.com": "password123"]
    guard let storedPassword = mockUsers[username] else {
        return "Error: user not found"
    }

    // Check password
    if storedPassword != password {
        return "Error: incorrect password"
    }

    // Generate session token
    let token = "\(username)-\(Int.random(in: 100000...999999))"

    // Format success response
    let response = """
    {
        "status": "success",
        "token": "\(token)",
        "user": "\(username)"
    }
    """
    return response
}
```

This function validates inputs, queries a data source, checks credentials,
generates a token, and formats a response, five distinct responsibilities
in one place.

**After (broken into focused functions):**

```swift
func validateLoginInputs(username: String, password: String) -> String? {
    if username.isEmpty || password.isEmpty {
        return "Error: fields cannot be empty"
    }
    if !username.contains("@") {
        return "Error: invalid email format"
    }
    if password.count < 8 {
        return "Error: password too short"
    }
    return nil
}

func findUser(username: String, in users: [String: String]) -> String? {
    return users[username]
}

func verifyPassword(_ input: String, against stored: String) -> Bool {
    return input == stored
}

func generateSessionToken(for username: String) -> String {
    return "\(username)-\(Int.random(in: 100000...999999))"
}

func formatLoginResponse(token: String, username: String) -> String {
    return """
    {
        "status": "success",
        "token": "\(token)",
        "user": "\(username)"
    }
    """
}

func processUserLogin(username: String, password: String) -> String {
    if let validationError = validateLoginInputs(username: username, password: password) {
        return validationError
    }

    let mockUsers = ["user@example.com": "password123"]
    guard let storedPassword = findUser(username: username, in: mockUsers) else {
        return "Error: user not found"
    }

    guard verifyPassword(password, against: storedPassword) else {
        return "Error: incorrect password"
    }

    let token = generateSessionToken(for: username)
    return formatLoginResponse(token: token, username: username)
}
```

### How Did Refactoring Improve the Structure?

The refactored `processUserLogin` now reads like a checklist of what login does: validate, find user, verify password, generate token, format response. Each step is named and its purpose is immediately clear without reading its implementation.

More importantly, each extracted function is independently testable and reusable. `validateLoginInputs` can be called before any form submission. `generateSessionToken` can be reused for session refresh. `formatLoginResponse` can be updated independently when the API response format changes without touching any of the other logic.

The original function had one name but five reasons to change. The refactored version distributes those reasons across five functions that each have exactly one reason to change.

## Avoiding Code Duplication

### The DRY Principle

DRY (Don't Repeat Yourself) states that every piece of knowledge should have a single, unambiguous representation in the codebase. When the same logic exists in multiple places, a change to that logic requires finding and updating every copy. Miss one, and the copies disagree which is worse than having no abstraction at all, because it creates silent inconsistency.

DRY is not just about avoiding copy-pasted code. It applies to configuration, constants, validation rules, and any logic that encodes a business rule. If the same truth is expressed in two places, those two places will eventually diverge.

### What Were the Issues with Duplicated Code?

**Before (duplicated validation and response formatting):**

```swift
func createAdminUser(name: String, email: String, age: Int) -> String {
    if name.isEmpty {
        return "Error: name cannot be empty"
    }
    if !email.contains("@") {
        return "Error: invalid email"
    }
    if age < 18 {
        return "Error: must be 18 or older"
    }
    return """
    {
        "status": "success",
        "role": "admin",
        "name": "\(name)",
        "email": "\(email)"
    }
    """
}

func createGuestUser(name: String, email: String, age: Int) -> String {
    if name.isEmpty {
        return "Error: name cannot be empty"
    }
    if !email.contains("@") {
        return "Error: invalid email"
    }
    if age < 18 {
        return "Error: must be 18 or older"
    }
    return """
    {
        "status": "success",
        "role": "guest",
        "name": "\(name)",
        "email": "\(email)"
    }
    """
}

func createModeratorUser(name: String, email: String, age: Int) -> String {
    if name.isEmpty {
        return "Error: name cannot be empty"
    }
    if !email.contains("@") {
        return "Error: invalid email"
    }
    if age < 18 {
        return "Error: must be 18 or older"
    }
    return """
    {
        "status": "success",
        "role": "moderator",
        "name": "\(name)",
        "email": "\(email)"
    }
    """
}
```

The validation logic is identical across all three functions. The response format is identical except for the role string. If the minimum age changes from 18 to 16, or the email validation rule changes, all three functions must be updated, and there is nothing stopping one of them from being missed.

**After (duplicated logic extracted):**

```swift
enum UserRole: String {
    case admin
    case guest
    case moderator
}

func validateUserInputs(name: String, email: String, age: Int) -> String? {
    if name.isEmpty { return "Error: name cannot be empty" }
    if !email.contains("@") { return "Error: invalid email" }
    if age < 18 { return "Error: must be 18 or older" }
    return nil
}

func formatUserResponse(role: UserRole, name: String, email: String) -> String {
    return """
    {
        "status": "success",
        "role": "\(role.rawValue)",
        "name": "\(name)",
        "email": "\(email)"
    }
    """
}

func createUser(role: UserRole, name: String, email: String,
                age: Int) -> String {
    if let error = validateUserInputs(name: name, email: email, age: age) {
        return error
    }
    return formatUserResponse(role: role, name: name, email: email)
}
```

### How Did Refactoring Improve Maintainability?

Three functions became one. The validation rule exists in exactly one place (`validateUserInputs`), so changing the minimum age or email format requires a single edit with zero risk of missing a copy. The response format exists in exactly one place (`formatUserResponse`), so adding a new field to the response requires one change, not three.

Adding a new role is now a one-line addition to the `UserRole` enum. In the original, adding a `moderator` role required duplicating the entire function a third time.

The refactored version also makes the relationship between the three original functions explicit, they all do the same thing with a different role. The original version hid that relationship behind three separate function names.

DRY is ultimately about making the codebase tell the truth. Duplicated code lies, so it implies that two things are different when they are actually the same. Abstracting the duplication makes the sameness visible and enforces it structurally rather than relying on discipline.

## Refactoring Code for Simplicity

### Common Refactoring Techniques

Refactoring is restructuring existing code without changing its external behavior. The goal is to make the code easier to understand and modify. Common techniques include:

- **Extract function:** pull a block of code into a named function
- **Inline variable:** replace a variable that only exists to name an expression with the expression itself when the name adds no clarity
- **Replace conditional with guard:** flatten nested conditions using early returns
- **Replace magic numbers with named constants:** make intent explicit
- **Simplify boolean expressions:** remove redundant comparisons like `== true` or `!= false`
- **Replace nested conditionals with polymorphism or enums:** use the type system to eliminate branching
- **Remove dead code:** delete code that is never reached or no longer used

The most important principle: refactor in small steps, verifying correctness at each step. Large refactors that change many things at once are risky and hard to review.

### What Made the Original Code Complex?

**Before (over-engineered and unnecessarily complex):**

```swift
class UserStatusChecker {
    private var statusMap: [String: [String: Any]] = [:]

    func initialize(with users: [(String, Int, Bool)]) {
        for user in users {
            var entry: [String: Any] = [:]
            entry["age"] = user.1
            entry["active"] = user.2
            statusMap[user.0] = entry
        }
    }

    func checkStatus(forUser identifier: String) -> String {
        if let userData = statusMap[identifier] {
            if let age = userData["age"] as? Int {
                if age >= 18 {
                    if let active = userData["active"] as? Bool {
                        if active == true {
                            return "eligible"
                        } else {
                            return "inactive"
                        }
                    } else {
                        return "unknown"
                    }
                } else {
                    return "underage"
                }
            } else {
                return "invalid"
            }
        } else {
            return "not found"
        }
    }
}

let checker = UserStatusChecker()
checker.initialize(with: [("alice", 25, true), ("bob", 16, true)])
let status = checker.checkStatus(forUser: "alice")
```

Problems with this code:
- A class is used when a simple function would do, as no state needs to be encapsulated between calls
- `statusMap` stores typed data as `[String: Any]`, losing type safety and requiring unsafe casts on every read
- Five levels of nested `if` statements to express what is fundamentally a linear sequence of checks
- Tuple indexing (`user.0`, `user.1`, `user.2`) instead of named properties
- The `if active == true` comparison is redundant, `active` is already a Bool

**After (simplified):**

```swift
struct User {
    let name: String
    let age: Int
    let isActive: Bool
}

func checkUserStatus(_ user: User) -> String {
    guard user.age >= 18 else { return "underage" }
    guard user.isActive else { return "inactive" }
    return "eligible"
}

let users = [
    User(name: "alice", age: 25, isActive: true),
    User(name: "bob", age: 16, isActive: true),
]

if let alice = users.first(where: { $0.name == "alice" }) {
    let status = checkUserStatus(alice)
}
```

### How Did Refactoring Improve It?

The class was replaced with a struct and a free function. There was no reason for a class, since no inheritance, no reference semantics, no shared mutable state. The unnecessary abstraction was removed entirely.

The `[String: Any]` dictionary was replaced with a typed `User` struct. Every field is now named, typed, and accessed without casting. The compiler catches type errors instead of crashing at runtime.

Five levels of nesting became two `guard` statements. Guard flattens the happy path, which the reader sees immediately what conditions are required and what happens when they fail, without tracking nested braces.

The tuple indexing (`user.0`) was replaced with named properties (`user.name`, `user.age`, `user.isActive`). The struct makes the data self-documenting.

The total line count went from 38 to 15. Every line removed was complexity that was not earning its place. Simplicity isn't about writing less code, but having no code that does not need to exist.

## Commenting & Documentation

### When Should You Add Comments?

Comments should explain **why**, not **what**. If the code is clear enough to explain what it does, a comment restating that is noise. If the reasoning behind a decision is not obvious from the code itself, a comment is essential.

**Add comments when:**

- **The reasoning is non-obvious:** A performance optimisation, a workaround for a known bug, a business rule that seems arbitrary, since these deserve explanation. The code shows what happens; the comment explains why it was done this way and not another.

    ```swift
    // Using linear search here instead of binary search because the array
    // is almost always fewer than 5 elements in practice. The overhead of
    // maintaining sorted order outweighs the search cost at this scale.
    let result = items.first(where: { $0.id == targetId })
    ```

- **A public API needs documentation:** Functions, classes, and modules that will be used by other developers, including future you, should have documentation comments explaining parameters, return values, and behaviour. In Swift this means `///` doc comments that appear in Xcode's quick help.

    ```swift
    /// Validates user inputs before account creation.
    /// - Parameters:
    ///   - name: The user's display name. Must not be empty.
    ///   - email: Must contain an `@` character.
    ///   - age: Must be 18 or older.
    /// - Returns: An error message string, or `nil` if all inputs are valid.
    func validateUserInputs(name: String, email: String, age: Int) -> String?
    ```

- **A workaround exists for an external constraint:** If you are working around a library bug, an OS limitation, or a third-party API quirk, document it and include a link to the issue or ticket if one exists. Without this, the next developer will remove the "unnecessary" workaround and reintroduce the bug.

    Below is an example a comment documenting a SwiftUI memory leak workaround (Source: [Soduto](https://github.com/sannidhyaroy/Soduto)):

    ```swift
    // SwiftUI TimelineView leaks attribute-graph nodes on every evaluation
    // regardless of rendering backend (Canvas, Metal shaders, or plain views).
    // With a 60fps schedule this produces unbounded memory growth (~0.3–1.5 MB/s,
    // visible as a sawtooth pattern in Instruments). `contentTransition(.numericText)`
    // amplifies the effect by adding per-character animation nodes each tick.
    //
    // A follow-up commit eliminated SwiftUI observation entirely for the hot path:
    // PlayerRemote.position and timestamp are non-@Published, routing updates
    // directly into the NSView via Combine without triggering SwiftUI body
    // re-evaluations. During normal playback this component now produces zero
    // SwiftUI body re-evaluations.
    //
    // See: github.com/sannidhyaroy/Soduto/commit/c413760, github.com/sannidhyaroy/Soduto/commit/db1c4d2
    ```

- **Regular expressions or complex algorithms need explanation.** A regex pattern is not self-documenting. A non-obvious algorithm deserves a reference to the source or a plain-language description of the approach.

### When Should You Avoid Comments and Improve the Code Instead?

A comment that compensates for unclear code is a red flag. The instinct to add a comment should first trigger the question: can I make the code clear enough that the comment is unnecessary?

**Avoid comments when:**

- **The comment restates what the code already says:** The comment adds nothing. Delete it.

    ```swift
    // Increment counter
    counter += 1
    ```

- **A better name would make the comment unnecessary:**

    ```swift
    // Check if user is old enough
    if age >= 18 { ... }
    
    // Better (no comment needed):
    let isEligibleAge = age >= 18
    if isEligibleAge { ... }
    ```

- **The comment is a section divider inside a long function:** If you are writing comments like `// Step 1: validate`, `// Step 2: fetch`, `// Step 3: format` inside a single function, those steps should be extracted into their own functions. The section dividers are a symptom of a function doing too much.

- **The comment describes what the code used to do:** Commented-out code and historical notes belong in version control history, not in the source file. `git log` and `git blame` preserve history, so dead code in comments is just clutter.

- **The comment will go stale:** A comment that says "this list has 5 items" becomes a lie the moment the list changes. Comments that describe state or counts rather than intent are almost always wrong eventually.

### Example: Poor Comments Rewritten

**Before (comments that add noise):**

```swift
// Function to get user
func getUser(id: Int) -> User? {
    // Loop through users
    for user in users {
        // Check if id matches
        if user.id == id {
            // Return the user
            return user
        }
    }
    // Return nil if not found
    return nil
}
```

Every comment here restates the code. They add reading overhead without adding understanding. Remove them all, as the code is already clear.

**After (no comments needed):**

```swift
func findUser(byId id: Int) -> User? {
    return users.first(where: { $0.id == id })
}
```

The rename from `getUser` to `findUser` is more expressive. The implementation is one line. No comments required.

**Before (missing a comment that matters):**

```swift
func calculateDiscount(for user: User) -> Double {
    if user.registrationDate < Date(timeIntervalSince1970: 1609459200) {
        return 0.20
    }
    return 0.10
}
```

**After (comment explains the why):**

```swift
func calculateDiscount(for user: User) -> Double {
    // Users who registered before 2021 are grandfathered into the legacy
    // 20% discount tier per the pricing policy change in Q1 2021.
    let legacyTierCutoff = Date(timeIntervalSince1970: 1609459200)
    if user.registrationDate < legacyTierCutoff {
        return 0.20
    }
    return 0.10
}
```

The magic number becomes a named constant, and the comment explains the business rule that no amount of renaming could make obvious.

### The Rule of Thumb

Write code that does not need comments. Write comments for everything that code cannot express: the why, the trade-off, the external constraint, the non-obvious invariant. A codebase with no comments at all is probably missing important context. A codebase where every line has a comment is probably compensating for unclear code.

## Handling Errors & Edge Cases

### Strategies for Error Handling

Robust code anticipates failure. Every function that receives input, accesses a resource, or performs an operation that can fail should handle the failure case explicitly rather than assuming success.

**Guard clauses** are the primary tool for this in Swift. A guard clause validates a precondition at the top of a function and exits early if it is not met, keeping the happy path unindented and clear:

```swift
func processOrder(order: Order?) {
    guard let order = order else {
        print("Error: order is nil")
        return
    }
    guard order.items.isEmpty == false else {
        print("Error: order has no items")
        return
    }
    guard order.total > 0 else {
        print("Error: invalid order total")
        return
    }
    // Happy path (all preconditions met)
    submitOrder(order)
}
```

Other key strategies:

- **Use `Result<Success, Failure>`** for functions that can fail in multiple ways, making the caller explicitly handle both cases
- **Use `throws` and `try/catch`** for operations that can fail with typed errors, giving callers structured error information
- **Validate at the boundary:** validate inputs as early as possible, at the point where data enters the system, rather than deep inside business logic
- **Fail loudly in development, gracefully in production:** use `assert()` and `precondition()` during development to catch programmer errors early, but handle user-facing errors gracefully without crashing
- **Never swallow errors silently:** an empty `catch` block or a forced `try!` is worse than no error handling at all because it hides failures

### What Was the Issue with the Original Code?

**Before (no error handling):**

```swift
func divide(_ a: Double, by b: Double) -> Double {
    return a / b
}

func getUserAge(from profile: [String: Any]) -> Int {
    return profile["age"] as! Int
}

func fetchFirstItem(from list: [String]) -> String {
    return list[0]
}
```

These three separate functions have three separate ways to crash:

- `divide(10, by: 0)` returns `infinity` or `nan` silently. Mathematically valid in IEEE 754 but almost certainly wrong in a business context
- `profile["age"] as! Int` crashes at runtime if `age` is missing, `nil`, or not an `Int`. Force unwrapping optional values is a deferred crash
- `list[0]` crashes with an index out of bounds exception if `list` is empty

None of these functions communicate that they can fail. The caller has no way to know they need to handle failure cases, and the failures are not handled gracefully, they either produce wrong results silently or crash.

**After (explicit error handling):**

```swift
enum AppError: Error {
    case divisionByZero
    case missingField(String)
    case invalidType(String)
    case emptyCollection
}

func divide(_ a: Double, by b: Double) throws -> Double {
    guard b != 0 else {
        throw AppError.divisionByZero
    }
    return a / b
}

func getUserAge(from profile: [String: Any]) throws -> Int {
    guard let value = profile["age"] else {
        throw AppError.missingField("age")
    }
    guard let age = value as? Int else {
        throw AppError.invalidType("age must be Int")
    }
    return age
}

func fetchFirstItem(from list: [String]) throws -> String {
    guard let first = list.first else {
        throw AppError.emptyCollection
    }
    return first
}

// Call site (forced to handle failure)
do {
    let result = try divide(10, by: 0)
    let age = try getUserAge(from: ["name": "Sannidhya"])
    let item = try fetchFirstItem(from: [])
} catch AppError.divisionByZero {
    print("Cannot divide by zero")
} catch AppError.missingField(let field) {
    print("Missing required field: \(field)")
} catch AppError.invalidType(let message) {
    print("Type error: \(message)")
} catch AppError.emptyCollection {
    print("List was empty")
}
```

### How Does Handling Errors Improve Reliability?

The refactored version makes failure visible at the call site. The `throws` keyword in the function signature is a contract, it tells every caller that this function can fail and you must decide what to do about it. The compiler enforces this, you cannot call a `throws` function without either using `try` inside a `do/catch` or propagating the error with `try` in your own `throws` function.

The typed `AppError` enum is important. It gives the caller structured information about what went wrong rather than a generic error message. A caller handling `divisionByZero` can take a different action than one handling `emptyCollection`, which is only possible if the error type encodes the distinction.

Guard clauses at the top of each function mean the failure cases are handled first and explicitly, before any business logic runs. This is the opposite of the original code where failures were implicit and scattered, or more accurately, not handled at all.

The most important improvement is that the original code could fail silently. `divide(10, by: 0)` returning `infinity` could propagate through an entire calculation pipeline before producing a wrong result that is difficult to trace back to its source. The refactored version fails immediately, loudly, and at the exact point of failure, making debugging significantly easier.

## Writing Unit Tests for Clean Code

### How Do Unit Tests Help Keep Code Clean?

Unit tests and clean code have a symbiotic relationship. Clean code is easier to test, and writing tests forces code to become cleaner.

A function that is hard to test is almost always a function with too many responsibilities, too many dependencies, or too many side effects. The act of writing a test exposes these problems immediately. If you cannot call a function in isolation with known inputs and verify its output, the function is doing too much or knows too much about the world around it.

Unit tests also act as a safety net for refactoring. Without tests, changing code requires manually verifying that nothing broke. With tests, the suite tells you immediately. This makes the Boy Scout Rule practical, you can clean up code you encounter without fear of introducing regressions.

Tests are also documentation. A well-written test suite describes exactly what a function is supposed to do under various conditions, including edge cases that might not be obvious from the implementation alone.

### Testing Framework

For this exercise, Swift Testing (introduced in Xcode 16) is used, the modern replacement for XCTest with a cleaner, macro-based API. The functions tested are from earlier sections of this milestone.

```swift
import Testing

// Testing the `validateUserInputs` function from the Naming section
@Test func testValidateUserInputs_validInputs() {
    let result = validateUserInputs(name: "Sannidhya", email: "s@example.com", age: 22)
    #expect(result == nil)
}

@Test func testValidateUserInputs_emptyName() {
    let result = validateUserInputs(name: "", email: "s@example.com", age: 22)
    #expect(result == "Error: name cannot be empty")
}

@Test func testValidateUserInputs_invalidEmail() {
    let result = validateUserInputs(name: "Sannidhya", email: "notanemail", age: 22)
    #expect(result == "Error: invalid email")
}

@Test func testValidateUserInputs_underage() {
    let result = validateUserInputs(name: "Sannidhya", email: "s@example.com", age: 16)
    #expect(result == "Error: must be 18 or older")
}

// Testing the divide function from the Error Handling section
@Test func testDivide_normalDivision() throws {
    let result = try divide(10, by: 2)
    #expect(result == 5.0)
}

@Test func testDivide_byZeroThrows() {
    #expect(throws: AppError.divisionByZero) {
        try divide(10, by: 0)
    }
}

// Edge cases
@Test func testValidateUserInputs_exactlyEighteen() {
    let result = validateUserInputs(name: "Sannidhya", email: "s@example.com", age: 18)
    #expect(result == nil)
}

@Test func testDivide_negativeNumbers() throws {
    let result = try divide(-10, by: 2)
    #expect(result == -5.0)
}
```

### What Issues Did I Find While Testing?

Writing the tests for `validateUserInputs` immediately revealed an ordering issue. The function checks name, then email, then age. If both name and email are invalid, only the name error is returned. Whether this is correct depends on requirements, should validation return all errors or just the first? The test suite made this decision visible and explicit.

The `divide` edge case tests also raised a question: what should happen with `divide(-10, by: -2)`? The function returns `5.0` which is mathematically correct, but the test forces you to consider whether negative inputs are a valid use case or should be rejected. Without the test, this assumption stays implicit.

This is the core value of unit testing beyond catching bugs, it forces you to make implicit assumptions explicit. Every test is a documented decision about how the code should behave.

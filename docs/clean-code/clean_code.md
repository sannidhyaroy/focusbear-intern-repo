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

| Setup & Installation | ESLint Violations (82 problems) |
| :------------------: | :-----------------------------: |
| ![ESLint Setup](../../assets/onboarding/Screenshot%202026-05-26%20at%203.09.14 PM.png) | ![ESLint Errors](../../assets/onboarding/CleanShot%202026-05-26%20at%2015.18.23@2x.png) |

| Prettier Diff | ESLint Violations (27 problems) after Prettier |
| :-----------: | :--------------------------------------------: |
| ![ESLint Errors](../../assets/onboarding/CleanShot%202026-05-26%20at%2015.24.21@2x.png) | ![Prettier Diff](../../assets/onboarding/Screenshot%202026-05-26%20at%203.28.03 PM.png) |

| After ESLint `--fix` (8 problems) | Manual Fixes Diff | ESLint Results |
| :-------------------------------: | :---------------: | :------------: |
| ![After Fix](../../assets/onboarding/Screenshot%202026-05-26%20at%203.30.39 PM.png) | ![Manual Fixes](../../assets/onboarding/Screenshot%202026-05-26%20at%208.50.18 PM.png) | ![After Prettier](../../assets/onboarding/Screenshot%202026-05-26%20at%208.47.13 PM.png) | 

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

**Before: unclear naming:**

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

**After: clear naming:**

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

**Before: one large function doing everything:**

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

**After: broken into focused functions:**

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

The refactored `processUserLogin` now reads like a checklist of what login does — validate, find user, verify password, generate token, format response. Each step is named and its purpose is immediately clear without reading its implementation.

More importantly, each extracted function is independently testable and reusable. `validateLoginInputs` can be called before any form submission. `generateSessionToken` can be reused for session refresh. `formatLoginResponse` can be updated independently when the API response format changes — without touching any of the other logic.

The original function had one name but five reasons to change. The refactored version distributes those reasons across five functions that each have exactly one reason to change.

## Avoiding Code Duplication

### The DRY Principle

DRY (Don't Repeat Yourself) states that every piece of knowledge should have a single, unambiguous representation in the codebase. When the same logic exists in multiple places, a change to that logic requires finding and updating every copy. Miss one, and the copies disagree which is worse than having no abstraction at all, because it creates silent inconsistency.

DRY is not just about avoiding copy-pasted code. It applies to configuration, constants, validation rules, and any logic that encodes a business rule. If the same truth is expressed in two places, those two places will eventually diverge.

### What Were the Issues with Duplicated Code?

**Before: duplicated validation and response formatting:**

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

**After: duplicated logic extracted:**

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
